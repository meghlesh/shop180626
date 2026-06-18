package com.cws.shop.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class CreateUserRequestDto {
	 @NotBlank(message = "Name is required")
	    @Size(min = 3, max = 100)
	    private String name;

	    @Email(message = "Invalid email")
	    @NotBlank(message = "Email is required")
	    private String email;

	    @NotBlank(message = "Mobile Number is required")
	    @Pattern(
	        regexp = "^[0-9]{10}$",
	        message = "Mobile number must be 10 digits"
	    )
	    private String mobileNumber;

	    @NotBlank(message = "Password is required")
	    @Size(min = 6, max = 20)
	    private String password;

	    public CreateUserRequestDto() {
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public String getEmail() {
	        return email;
	    }

	    public void setEmail(String email) {
	        this.email = email;
	    }

	    public String getMobileNumber() {
	        return mobileNumber;
	    }

	    public void setMobileNumber(String mobileNumber) {
	        this.mobileNumber = mobileNumber;
	    }

	    public String getPassword() {
	        return password;
	    }

	    public void setPassword(String password) {
	        this.password = password;
	    }
	
}
