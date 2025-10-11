package com.zoedatalab.empleos.common.time;

import java.time.Instant;

public interface ClockPort {
    Instant now();
}
