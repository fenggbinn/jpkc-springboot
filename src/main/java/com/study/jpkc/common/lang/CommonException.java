package com.study.jpkc.common.lang;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 通用异常
 * @Author Harlan
 * @Date 2021/1/4
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommonException extends RuntimeException{
    private Integer code;
    private String message;
}