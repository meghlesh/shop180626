package com.cws.shop.service;

import java.time.LocalDate;

public interface EmailService {
	
	void sendVerificationEmail(
            String toEmail,
            String userName,
            String verificationLink
    );

    void sendResetPasswordEmail(
            String toEmail,
            String userName,
            String resetLink
    );

    void sendLicenseEmail(
            String toEmail,
            String customerName,
            String productName,
            String licenseKey,
            String licenseType,
            String licensePlan,
            LocalDate activationDate,
            LocalDate expiryDate,
            Integer activationLimit
    );
}
