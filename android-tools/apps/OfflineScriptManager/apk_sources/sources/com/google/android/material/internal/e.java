package com.google.android.material.internal;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ValueAnimator;
import android.util.StateSet;
import java.util.ArrayList;
/* loaded from: classes.dex */
public final class e {

    /* renamed from: a  reason: collision with root package name */
    private final ArrayList<b> f2358a = new ArrayList<>();

    /* renamed from: b  reason: collision with root package name */
    private b f2359b = null;

    /* renamed from: c  reason: collision with root package name */
    ValueAnimator f2360c = null;

    /* renamed from: d  reason: collision with root package name */
    private final Animator.AnimatorListener f2361d = new a();

    /* loaded from: classes.dex */
    class a extends AnimatorListenerAdapter {
        a() {
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            e eVar = e.this;
            if (eVar.f2360c == animator) {
                eVar.f2360c = null;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        final int[] f2363a;

        /* renamed from: b  reason: collision with root package name */
        final ValueAnimator f2364b;

        b(int[] iArr, ValueAnimator valueAnimator) {
            this.f2363a = iArr;
            this.f2364b = valueAnimator;
        }
    }

    private void b() {
        ValueAnimator valueAnimator = this.f2360c;
        if (valueAnimator != null) {
            valueAnimator.cancel();
            this.f2360c = null;
        }
    }

    private void e(b bVar) {
        ValueAnimator valueAnimator = bVar.f2364b;
        this.f2360c = valueAnimator;
        valueAnimator.start();
    }

    public void a(int[] iArr, ValueAnimator valueAnimator) {
        b bVar = new b(iArr, valueAnimator);
        valueAnimator.addListener(this.f2361d);
        this.f2358a.add(bVar);
    }

    public void c() {
        ValueAnimator valueAnimator = this.f2360c;
        if (valueAnimator != null) {
            valueAnimator.end();
            this.f2360c = null;
        }
    }

    public void d(int[] iArr) {
        b bVar;
        int size = this.f2358a.size();
        int i = 0;
        while (true) {
            if (i >= size) {
                bVar = null;
                break;
            }
            bVar = this.f2358a.get(i);
            if (StateSet.stateSetMatches(bVar.f2363a, iArr)) {
                break;
            }
            i++;
        }
        b bVar2 = this.f2359b;
        if (bVar == bVar2) {
            return;
        }
        if (bVar2 != null) {
            b();
        }
        this.f2359b = bVar;
        if (bVar != null) {
            e(bVar);
        }
    }
}
