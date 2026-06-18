package com.cws.shop.controller;

import com.cws.shop.dto.response.ApiResponse;
import com.cws.shop.service.FileStorageService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user/products")
public class ProductDownloadController {

    private final FileStorageService fileStorageService;

    // TODO: Inject LicenseService here once License Management is implemented
    // private final LicenseService licenseService;

    public ProductDownloadController(FileStorageService fileStorageService) {
        this.fileStorageService = fileStorageService;
    }

   
    @GetMapping("/{productId}/download")
    public ResponseEntity<ApiResponse<String>> getDownloadUrl(
            @PathVariable Long productId,
            @RequestParam("publicId") String publicId,
            Authentication authentication) {

     
        String signedUrl = fileStorageService.generateSecureDownloadUrl(publicId, 3600);

        return ResponseEntity.ok(
                new ApiResponse<>(true, "Download link is valid for 1 hour.", signedUrl)
        );
    }
}