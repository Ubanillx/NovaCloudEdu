package com.novacloudedu.backend.domain.payment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 支付结果
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentResult {

    private boolean success;
    
    private String message;
    
    private String orderNo;
    
    private String paymentData;
    
    private String paymentUrl;
}
