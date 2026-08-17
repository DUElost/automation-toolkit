package androidx.appcompat.widget;

import android.content.Context;
import android.graphics.Bitmap;
import android.util.AttributeSet;
import android.view.View;
import android.widget.RatingBar;
/* loaded from: classes.dex */
public class q extends RatingBar {

    /* renamed from: b  reason: collision with root package name */
    private final p f749b;

    public q(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.a.a.ratingBarStyle);
    }

    public q(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        p pVar = new p(this);
        this.f749b = pVar;
        pVar.c(attributeSet, i);
    }

    @Override // android.widget.RatingBar, android.widget.AbsSeekBar, android.widget.ProgressBar, android.view.View
    protected synchronized void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        Bitmap b2 = this.f749b.b();
        if (b2 != null) {
            setMeasuredDimension(View.resolveSizeAndState(b2.getWidth() * getNumStars(), i, 0), getMeasuredHeight());
        }
    }
}
