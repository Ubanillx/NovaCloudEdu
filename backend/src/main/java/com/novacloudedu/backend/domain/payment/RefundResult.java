package com.novacloudedu.backend.domain.payment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * 退款结果
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RefundResult {

    private boolean success;
    
    private String orderNo;
    
    private BigDecimal refundAmount;
    
    private String message;
}
