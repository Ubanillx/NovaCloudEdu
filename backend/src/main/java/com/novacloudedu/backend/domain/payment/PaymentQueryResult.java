package com.novacloudedu.backend.domain.payment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 支付查询结果
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentQueryResult {

    private boolean success;
    
    private String orderNo;
    
    private boolean paid;
    
    private BigDecimal amount;
    
    private LocalDateTime paymentTime;
    
    private String message;
}
