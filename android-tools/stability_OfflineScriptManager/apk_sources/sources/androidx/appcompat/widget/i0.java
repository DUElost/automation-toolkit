package androidx.appcompat.widget;
/* loaded from: classes.dex */
class i0 {

    /* renamed from: a  reason: collision with root package name */
    private int f702a = 0;

    /* renamed from: b  reason: collision with root package name */
    private int f703b = 0;

    /* renamed from: c  reason: collision with root package name */
    private int f704c = Integer.MIN_VALUE;

    /* renamed from: d  reason: collision with root package name */
    private int f705d = Integer.MIN_VALUE;
    private int e = 0;
    private int f = 0;
    private boolean g = false;
    private boolean h = false;

    public int a() {
        return this.g ? this.f702a : this.f703b;
    }

    public int b() {
        return this.f702a;
    }

    public int c() {
        return this.f703b;
    }

    public int d() {
        return this.g ? this.f703b : this.f702a;
    }

    public void e(int i, int i2) {
        this.h = false;
        if (i != Integer.MIN_VALUE) {
            this.e = i;
            this.f702a = i;
        }
        if (i2 != Integer.MIN_VALUE) {
            this.f = i2;
            this.f703b = i2;
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:14:0x001a, code lost:
        if (r2 != Integer.MIN_VALUE) goto L15;
     */
    /* JADX WARN: Code restructure failed: missing block: B:21:0x0028, code lost:
        if (r2 != Integer.MIN_VALUE) goto L15;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void f(boolean r2) {
        /*
            r1 = this;
            boolean r0 = r1.g
            if (r2 != r0) goto L5
            return
        L5:
            r1.g = r2
            boolean r0 = r1.h
            if (r0 == 0) goto L2b
            r0 = -2147483648(0xffffffff80000000, float:-0.0)
            if (r2 == 0) goto L1d
            int r2 = r1.f705d
            if (r2 == r0) goto L14
            goto L16
        L14:
            int r2 = r1.e
        L16:
            r1.f702a = r2
            int r2 = r1.f704c
            if (r2 == r0) goto L2f
            goto L31
        L1d:
            int r2 = r1.f704c
            if (r2 == r0) goto L22
            goto L24
        L22:
            int r2 = r1.e
        L24:
            r1.f702a = r2
            int r2 = r1.f705d
            if (r2 == r0) goto L2f
            goto L31
        L2b:
            int r2 = r1.e
            r1.f702a = r2
        L2f:
            int r2 = r1.f
        L31:
            r1.f703b = r2
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.widget.i0.f(boolean):void");
    }

    public void g(int i, int i2) {
        this.f704c = i;
        this.f705d = i2;
        this.h = true;
        if (this.g) {
            if (i2 != Integer.MIN_VALUE) {
                this.f702a = i2;
            }
            if (i != Integer.MIN_VALUE) {
                this.f703b = i;
                return;
            }
            return;
        }
        if (i != Integer.MIN_VALUE) {
            this.f702a = i;
        }
        if (i2 != Integer.MIN_VALUE) {
            this.f703b = i2;
        }
    }
}
