#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
重试工具模块
------------

提供网络请求重试、指数退避等健壮性工具。
"""

from __future__ import annotations

import logging
import time
from functools import wraps
from typing import Any, Callable, Optional, Tuple, Type, Union

logger = logging.getLogger(__name__)

# 可重试的异常类型
RETRYABLE_EXCEPTIONS: Tuple[Type[Exception], ...] = (
    ConnectionError,
    TimeoutError,
    OSError,
)


def retry_with_backoff(
    max_attempts: int = 3,
    base_delay: float = 1.0,
    max_delay: float = 30.0,
    exponential_base: float = 2.0,
    retryable_exceptions: Optional[Tuple[Type[Exception], ...]] = None,
):
    """
    带指数退避的重试装饰器。
    
    Args:
        max_attempts: 最大重试次数
        base_delay: 基础延迟（秒）
        max_delay: 最大延迟（秒）
        exponential_base: 指数基数
        retryable_exceptions: 可重试的异常类型
    """
    if retryable_exceptions is None:
        retryable_exceptions = RETRYABLE_EXCEPTIONS
    
    def decorator(func: Callable) -> Callable:
        @wraps(func)
        def wrapper(*args, **kwargs) -> Any:
            last_exception = None
            
            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except retryable_exceptions as e:
                    last_exception = e
                    if attempt < max_attempts:
                        delay = min(base_delay * (exponential_base ** (attempt - 1)), max_delay)
                        logger.warning(
                            "重试 %s 第 %d/%d 次，延迟 %.1f 秒: %s",
                            func.__name__, attempt, max_attempts, delay, e
                        )
                        time.sleep(delay)
                    else:
                        logger.error("重试 %s 已达最大次数 %d: %s", func.__name__, max_attempts, e)
                except Exception as e:
                    # 非可重试异常直接抛出
                    raise
            
            if last_exception:
                raise last_exception
        
        return wrapper
    return decorator


class RetryContext:
    """重试上下文管理器，用于更细粒度的重试控制。"""
    
    def __init__(
        self,
        max_attempts: int = 3,
        base_delay: float = 1.0,
        max_delay: float = 30.0,
        exponential_base: float = 2.0,
    ):
        self.max_attempts = max_attempts
        self.base_delay = base_delay
        self.max_delay = max_delay
        self.exponential_base = exponential_base
        self.attempt = 0
        self.last_exception: Optional[Exception] = None
    
    def should_retry(self, exception: Exception) -> bool:
        """判断是否应该重试。"""
        self.last_exception = exception
        self.attempt += 1
        
        if self.attempt >= self.max_attempts:
            return False
        
        if isinstance(exception, RETRYABLE_EXCEPTIONS):
            delay = min(
                self.base_delay * (self.exponential_base ** (self.attempt - 1)),
                self.max_delay
            )
            logger.warning("重试第 %d/%d 次，延迟 %.1f 秒", self.attempt, self.max_attempts, delay)
            time.sleep(delay)
            return True
        
        return False
    
    def reset(self):
        """重置重试状态。"""
        self.attempt = 0
        self.last_exception = None
