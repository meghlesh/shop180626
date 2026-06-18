package com.cws.shop.serviceImpl;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.cws.shop.exception.UserNotFoundException;
import com.cws.shop.model.Cart;
import com.cws.shop.model.CartItem;
import com.cws.shop.model.OrderStatus;
import com.cws.shop.model.Payment;
import com.cws.shop.model.PaymentStatus;
import com.cws.shop.model.Product;
import com.cws.shop.model.User;
import com.cws.shop.repository.CartItemRepository;
import com.cws.shop.repository.CartRepository;
import com.cws.shop.repository.OrderRepository;
import com.cws.shop.repository.PaymentRepository;
import com.cws.shop.repository.UserRepository;
import com.cws.shop.service.PaymentService;
//import com.cws.shop.util.RazorpaySignatureUtil;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.Utils;

@Service
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private RazorpayClient razorpayClient;

    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Value("${razorpay.key-secret}")
    private String razorpaySecret;

    // =========================
    // CREATE ORDER
    // =========================
    @Override
    public JSONObject createOrder(Double amount, Long userId) throws Exception {
    	
    	 User user = userRepository.findById(userId)
    	            .orElseThrow(() ->
    	                    new UserNotFoundException("User not found"));

        JSONObject options = new JSONObject();
        options.put("amount", amount * 100); // convert to paise
        options.put("currency", "INR");
        options.put("receipt", "order_rcptid_" + System.currentTimeMillis());
        options.put("payment_capture", 1);

        Order razorpayOrder = razorpayClient.orders.create(options);

        // Save payment in DB
        Payment payment = new Payment();
        payment.setOrderId(razorpayOrder.get("id"));
        payment.setBuyerId(userId);
        payment.setAmount(amount);
        payment.setCurrency("INR");   
        payment.setStatus(PaymentStatus.PENDING);
        
        
        System.out.println("Before Save: " + payment);

        Payment savedPayment = paymentRepository.save(payment);

        System.out.println("After Save: " + savedPayment);
//        paymentRepository.save(payment);

        return new JSONObject(razorpayOrder.toString());
    }

    // =========================
    // VERIFY PAYMENT
    // =========================
    @Override
    public boolean verifyPayment(String razorpayOrderId,
                                 String razorpayPaymentId,
                                 String razorpaySignature) throws Exception {

        Payment payment = paymentRepository.findByOrderId(razorpayOrderId);

        if (payment == null) {
            return false;
        }

        JSONObject params = new JSONObject();
        params.put("razorpay_order_id", razorpayOrderId);
        params.put("razorpay_payment_id", razorpayPaymentId);
        params.put("razorpay_signature", razorpaySignature);

        boolean isValid = Utils.verifyPaymentSignature(params, razorpaySecret);

        if (isValid) {
            payment.setStatus(PaymentStatus.SUCCESS);
            payment.setPaymentId(razorpayPaymentId);
            payment.setSignature(razorpaySignature);
            
            Long userId = payment.getBuyerId();

            User user = userRepository.findById(userId)
                    .orElseThrow(() ->
                            new UserNotFoundException("User not found"));

            Cart cart = cartRepository.findByUser(user)
                    .orElseThrow(() ->
                            new RuntimeException("Cart not found"));

            if (cart.getItems().isEmpty()) {
                throw new RuntimeException("Cart is empty");
            }

            // Calculate Total Amount
         // Calculate Subtotal
            double subtotal = 0;
            double discount = 0;

            for (CartItem item : cart.getItems()) {

                Product product = item.getProduct();

                double originalPrice = product.getPrice();

                double discountedPrice =
                        (product.getDiscountedPrice() != null
                                && product.getDiscountedPrice() > 0)
                        ? product.getDiscountedPrice()
                        : originalPrice;

                subtotal += originalPrice * item.getQuantity();

                discount += (originalPrice - discountedPrice)
                        * item.getQuantity();
            }

            double netAmount = subtotal - discount;

            double gst = Math.round(netAmount * 18.0 / 100.0);

            double totalAmount = netAmount + gst;

            // Product Names
            String products = cart.getItems()
                    .stream()
                    .map(item -> item.getProduct().getName())
                    .reduce((a, b) -> a + ", " + b)
                    .orElse("");

            // Create Ecommerce Order
            com.cws.shop.model.Order order =
                    new com.cws.shop.model.Order();

            order.setUser(user);

            order.setOrderId("ORD-" + System.currentTimeMillis());

            order.setAmount(totalAmount);
            order.setCustomerName(user.getName());

            order.setProductPurchased(products);

            order.setPaymentMethod("RAZORPAY");

            order.setTransactionStatus("SUCCESS");

            order.setLastUpdated(java.time.LocalDateTime.now());
            order.setStatus(OrderStatus.COMPLETED);

            orderRepository.save(order);

            // Clear Cart
            System.out.println("Cart Items Before Delete: "
                    + cart.getItems().size());

            cart.getItems().clear();
            cartRepository.save(cart);
            System.out.println("Delete Method Executed");

            System.out.println("Cart Items After Delete: "
                    + cartItemRepository.findAll().size());
            } else {
            payment.setStatus(PaymentStatus.FAILED);
        }

        paymentRepository.save(payment);

        return isValid;
    }

    @Override
    public boolean handleWebhook(String payload, String signature) throws Exception {

    	boolean isValid = Utils.verifyWebhookSignature(
    	        payload,
    	        signature,
    	        razorpaySecret
    	);

        if (isValid) {

            JSONObject json = new JSONObject(payload);

            String orderId = json
                    .getJSONObject("payload")
                    .getJSONObject("payment")
                    .getJSONObject("entity")
                    .getString("order_id");

            String paymentStatus = json
                    .getJSONObject("payload")
                    .getJSONObject("payment")
                    .getJSONObject("entity")
                    .getString("status");

            Payment payment = paymentRepository.findByOrderId(orderId);

            if (payment != null) {

                if ("captured".equals(paymentStatus)) {
                    payment.setStatus(PaymentStatus.SUCCESS);
                } else {
                    payment.setStatus(PaymentStatus.FAILED);
                }

                paymentRepository.save(payment);
            }
        }

        return isValid;
    }
}