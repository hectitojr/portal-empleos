package com.zoedatalab.empleos.api.adapters;

import com.zoedatalab.empleos.common.time.ClockPort;
import org.springframework.stereotype.Component;

import java.time.Instant;

@Component
public class SystemClockAdapter implements ClockPort {
    @Override public Instant now() {
        return Instant.now();
    }
}
