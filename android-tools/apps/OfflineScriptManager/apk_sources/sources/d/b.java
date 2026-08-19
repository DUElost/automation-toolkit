package d;
/* loaded from: classes.dex */
public enum b {
    MESSAGE_PIPE_GRANULARITY(256),
    COMMAND_PIPE_GRANULARITY(16),
    INBOUND_POLL_RATE(100),
    IN_BATCH_SIZE(8192),
    OUT_BATCH_SIZE(8192),
    MAX_WM_DELTA(1024),
    MAX_IO_EVENTS(256),
    MAX_COMMAND_DELAY(3000000),
    CLOCK_PRECISION(1000000),
    PGM_MAX_TPDU(1500),
    SIGNALER_PORT(0),
    MSG_ALLOCATION_HEAP_THRESHOLD(1048576);
    

    /* renamed from: b  reason: collision with root package name */
    private final int f2524b;

    b(int i) {
        this.f2524b = i;
    }

    /* renamed from: values  reason: to resolve conflict with enum method */
    public static b[] valuesCustom() {
        b[] valuesCustom = values();
        int length = valuesCustom.length;
        b[] bVarArr = new b[length];
        System.arraycopy(valuesCustom, 0, bVarArr, 0, length);
        return bVarArr;
    }

    public int a() {
        return this.f2524b;
    }
}
