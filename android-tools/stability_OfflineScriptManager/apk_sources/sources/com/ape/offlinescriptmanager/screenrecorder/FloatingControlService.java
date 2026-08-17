package com.ape.offlinescriptmanager.screenrecorder;

import android.animation.Animator;
import android.animation.ValueAnimator;
import android.app.Service;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Binder;
import android.os.Build;
import android.os.IBinder;
import android.os.Vibrator;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import com.ape.offlinescriptmanager.screenrecorder.a;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class FloatingControlService extends Service implements View.OnClickListener {

    /* renamed from: b  reason: collision with root package name */
    private WindowManager f1988b;

    /* renamed from: c  reason: collision with root package name */
    private LinearLayout f1989c;

    /* renamed from: d  reason: collision with root package name */
    private View f1990d;
    private ImageButton e;
    private ImageButton f;
    private IBinder g = new e();

    /* loaded from: classes.dex */
    class a implements View.OnTouchListener {

        /* renamed from: b  reason: collision with root package name */
        private WindowManager.LayoutParams f1991b;

        /* renamed from: c  reason: collision with root package name */
        private int f1992c;

        /* renamed from: d  reason: collision with root package name */
        private int f1993d;
        private float e;
        private float f;
        boolean g = false;
        final /* synthetic */ WindowManager.LayoutParams h;

        a(WindowManager.LayoutParams layoutParams) {
            this.h = layoutParams;
            this.f1991b = layoutParams;
        }

        @Override // android.view.View.OnTouchListener
        public boolean onTouch(View view, MotionEvent motionEvent) {
            int action = motionEvent.getAction();
            if (action == 0) {
                this.g = false;
                WindowManager.LayoutParams layoutParams = this.f1991b;
                this.f1992c = layoutParams.x;
                this.f1993d = layoutParams.y;
                this.e = motionEvent.getRawX();
                this.f = motionEvent.getRawY();
            } else if (action != 1) {
                if (action == 2) {
                    int rawX = (int) (motionEvent.getRawX() - this.e);
                    int rawY = (int) (motionEvent.getRawY() - this.f);
                    WindowManager.LayoutParams layoutParams2 = this.f1991b;
                    layoutParams2.x = this.f1992c + rawX;
                    layoutParams2.y = this.f1993d + rawY;
                    if (Math.abs(rawX) > 10 || Math.abs(rawY) > 10) {
                        this.g = true;
                    }
                    FloatingControlService.this.f1988b.updateViewLayout(FloatingControlService.this.f1989c, this.f1991b);
                }
            } else if (!this.g) {
                if (FloatingControlService.this.f1990d.getVisibility() == 4) {
                    FloatingControlService.this.h();
                } else {
                    FloatingControlService.this.f();
                }
            }
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements Animator.AnimatorListener {
        b() {
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            FloatingControlService.this.f1990d.setVisibility(4);
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationRepeat(Animator animator) {
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements ValueAnimator.AnimatorUpdateListener {
        c() {
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            int intValue = ((Integer) valueAnimator.getAnimatedValue()).intValue();
            ViewGroup.LayoutParams layoutParams = FloatingControlService.this.f1990d.getLayoutParams();
            layoutParams.width = intValue;
            FloatingControlService.this.f1990d.setLayoutParams(layoutParams);
        }
    }

    /* loaded from: classes.dex */
    static /* synthetic */ class d {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1996a;

        static {
            int[] iArr = new int[a.EnumC0076a.values().length];
            f1996a = iArr;
            try {
                iArr[a.EnumC0076a.PAUSED.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1996a[a.EnumC0076a.RECORDING.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
        }
    }

    /* loaded from: classes.dex */
    public class e extends Binder {
        public e() {
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public FloatingControlService a() {
            return FloatingControlService.this;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void f() {
        ValueAnimator l = l(this.f1990d.getWidth(), 0);
        l.addListener(new b());
        l.start();
    }

    private int g(int i) {
        return Math.round(i * (getResources().getDisplayMetrics().xdpi / 160.0f));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h() {
        this.f1990d.setVisibility(0);
        this.f1990d.measure(View.MeasureSpec.makeMeasureSpec(0, 0), View.MeasureSpec.makeMeasureSpec(0, 0));
        l(0, this.f1990d.getMeasuredWidth()).start();
    }

    private void i() {
        Intent intent = new Intent(this, RecorderService.class);
        intent.setAction("com.ape.offlinescriptmanager.screenrecorder.services.action.pauserecording");
        startService(intent);
    }

    private void j() {
        Intent intent = new Intent(this, RecorderService.class);
        intent.setAction("com.ape.offlinescriptmanager.screenrecorder.services.action.resumerecording");
        startService(intent);
    }

    private ValueAnimator l(int i, int i2) {
        ValueAnimator ofInt = ValueAnimator.ofInt(i, i2);
        ofInt.addUpdateListener(new c());
        return ofInt;
    }

    private void m() {
        Intent intent = new Intent(this, RecorderService.class);
        intent.setAction("com.ape.offlinescriptmanager.screenrecorder.services.action.stoprecording");
        startService(intent);
    }

    public void k(a.EnumC0076a enumC0076a) {
        int i = d.f1996a[enumC0076a.ordinal()];
        if (i == 1) {
            this.e.setEnabled(false);
            this.f.setEnabled(true);
        } else if (i != 2) {
        } else {
            this.e.setEnabled(true);
            this.f.setEnabled(false);
        }
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        Log.d("SCREENRECORDER", "Binding successful!");
        return this.g;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id == R.id.pause) {
            i();
        } else if (id == R.id.resume) {
            j();
        } else if (id == R.id.stop) {
            m();
        }
        ((Vibrator) getSystemService("vibrator")).vibrate(100L);
    }

    @Override // android.app.Service
    public void onDestroy() {
        LinearLayout linearLayout = this.f1989c;
        if (linearLayout != null) {
            this.f1988b.removeView(linearLayout);
        }
        super.onDestroy();
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        this.f1988b = (WindowManager) getSystemService("window");
        LinearLayout linearLayout = (LinearLayout) ((LayoutInflater) getSystemService("layout_inflater")).inflate(R.layout.layout_floating_controls, (ViewGroup) null);
        this.f1989c = linearLayout;
        View findViewById = linearLayout.findViewById(R.id.controls);
        this.f1990d = findViewById;
        this.e = (ImageButton) this.f1990d.findViewById(R.id.pause);
        ImageButton imageButton = (ImageButton) this.f1990d.findViewById(R.id.resume);
        this.f = imageButton;
        imageButton.setEnabled(false);
        ((ImageButton) findViewById.findViewById(R.id.stop)).setOnClickListener(this);
        SharedPreferences defaultSharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
        if (Build.VERSION.SDK_INT < 24) {
            this.e.setVisibility(8);
            this.f.setVisibility(8);
            this.f1990d.findViewById(R.id.divider1).setVisibility(8);
            this.f1990d.findViewById(R.id.divider2).setVisibility(8);
        } else {
            this.e.setOnClickListener(this);
            this.f.setOnClickListener(this);
        }
        WindowManager.LayoutParams layoutParams = new WindowManager.LayoutParams(-2, g(defaultSharedPreferences.getInt(getString(R.string.preference_floating_control_size_key), 100)), 2002, 8, -3);
        layoutParams.gravity = 8388659;
        layoutParams.x = 0;
        layoutParams.y = 100;
        this.f1988b.addView(this.f1989c, layoutParams);
        try {
            this.f1989c.setOnTouchListener(new a(layoutParams));
            return 1;
        } catch (Exception unused) {
            return 1;
        }
    }

    @Override // android.app.Service
    public boolean onUnbind(Intent intent) {
        Log.d("SCREENRECORDER", "Unbinding and stopping service");
        stopSelf();
        return super.onUnbind(intent);
    }
}
