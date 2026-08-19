package androidx.recyclerview.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.util.Log;
import android.view.View;
import androidx.recyclerview.widget.RecyclerView;
/* loaded from: classes.dex */
public class d extends RecyclerView.n {

    /* renamed from: d  reason: collision with root package name */
    private static final int[] f1231d = {16843284};

    /* renamed from: a  reason: collision with root package name */
    private Drawable f1232a;

    /* renamed from: b  reason: collision with root package name */
    private int f1233b;

    /* renamed from: c  reason: collision with root package name */
    private final Rect f1234c = new Rect();

    public d(Context context, int i) {
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(f1231d);
        Drawable drawable = obtainStyledAttributes.getDrawable(0);
        this.f1232a = drawable;
        if (drawable == null) {
            Log.w("DividerItem", "@android:attr/listDivider was not set in the theme used for this DividerItemDecoration. Please set that attribute all call setDrawable()");
        }
        obtainStyledAttributes.recycle();
        l(i);
    }

    private void j(Canvas canvas, RecyclerView recyclerView) {
        int height;
        int i;
        canvas.save();
        if (recyclerView.getClipToPadding()) {
            i = recyclerView.getPaddingTop();
            height = recyclerView.getHeight() - recyclerView.getPaddingBottom();
            canvas.clipRect(recyclerView.getPaddingLeft(), i, recyclerView.getWidth() - recyclerView.getPaddingRight(), height);
        } else {
            height = recyclerView.getHeight();
            i = 0;
        }
        int childCount = recyclerView.getChildCount();
        for (int i2 = 0; i2 < childCount; i2++) {
            View childAt = recyclerView.getChildAt(i2);
            recyclerView.getLayoutManager().O(childAt, this.f1234c);
            int round = this.f1234c.right + Math.round(childAt.getTranslationX());
            this.f1232a.setBounds(round - this.f1232a.getIntrinsicWidth(), i, round, height);
            this.f1232a.draw(canvas);
        }
        canvas.restore();
    }

    private void k(Canvas canvas, RecyclerView recyclerView) {
        int width;
        int i;
        canvas.save();
        if (recyclerView.getClipToPadding()) {
            i = recyclerView.getPaddingLeft();
            width = recyclerView.getWidth() - recyclerView.getPaddingRight();
            canvas.clipRect(i, recyclerView.getPaddingTop(), width, recyclerView.getHeight() - recyclerView.getPaddingBottom());
        } else {
            width = recyclerView.getWidth();
            i = 0;
        }
        int childCount = recyclerView.getChildCount();
        for (int i2 = 0; i2 < childCount; i2++) {
            View childAt = recyclerView.getChildAt(i2);
            recyclerView.g0(childAt, this.f1234c);
            int round = this.f1234c.bottom + Math.round(childAt.getTranslationY());
            this.f1232a.setBounds(i, round - this.f1232a.getIntrinsicHeight(), width, round);
            this.f1232a.draw(canvas);
        }
        canvas.restore();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.n
    public void e(Rect rect, View view, RecyclerView recyclerView, RecyclerView.z zVar) {
        Drawable drawable = this.f1232a;
        if (drawable == null) {
            rect.set(0, 0, 0, 0);
        } else if (this.f1233b == 1) {
            rect.set(0, 0, 0, drawable.getIntrinsicHeight());
        } else {
            rect.set(0, 0, drawable.getIntrinsicWidth(), 0);
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.n
    public void g(Canvas canvas, RecyclerView recyclerView, RecyclerView.z zVar) {
        if (recyclerView.getLayoutManager() == null || this.f1232a == null) {
            return;
        }
        if (this.f1233b == 1) {
            k(canvas, recyclerView);
        } else {
            j(canvas, recyclerView);
        }
    }

    public void l(int i) {
        if (i != 0 && i != 1) {
            throw new IllegalArgumentException("Invalid orientation. It should be either HORIZONTAL or VERTICAL");
        }
        this.f1233b = i;
    }
}
