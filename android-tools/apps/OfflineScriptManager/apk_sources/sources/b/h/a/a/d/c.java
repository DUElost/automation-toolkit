package b.h.a.a.d;

import android.content.Context;
import android.graphics.Rect;
import android.view.FocusFinder;
import android.view.KeyEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.animation.AnimationUtils;
import android.widget.FrameLayout;
import android.widget.Scroller;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class c extends FrameLayout {

    /* renamed from: b  reason: collision with root package name */
    private long f1682b;

    /* renamed from: c  reason: collision with root package name */
    private final Rect f1683c;

    /* renamed from: d  reason: collision with root package name */
    private Scroller f1684d;
    private boolean e;
    private float f;
    private float g;
    private boolean h;
    private View i;
    private boolean j;
    private VelocityTracker k;
    private int l;
    private int m;
    private int n;

    public c(Context context) {
        super(context);
        this.f1683c = new Rect();
        this.h = true;
        this.i = null;
        this.j = false;
        k();
    }

    private boolean b() {
        View childAt = getChildAt(0);
        if (childAt != null) {
            return getHeight() < (childAt.getHeight() + getPaddingTop()) + getPaddingBottom() || getWidth() < (childAt.getWidth() + getPaddingLeft()) + getPaddingRight();
        }
        return false;
    }

    private int c(int i, int i2, int i3) {
        if (i2 >= i3 || i < 0) {
            return 0;
        }
        return i2 + i > i3 ? i3 - i2 : i;
    }

    private void e(int i, int i2) {
        if (i == 0 && i2 == 0) {
            return;
        }
        p(i, i2);
    }

    private View g(boolean z, int i, int i2, boolean z2, int i3, int i4) {
        ArrayList focusables = getFocusables(2);
        int size = focusables.size();
        View view = null;
        boolean z3 = false;
        for (int i5 = 0; i5 < size; i5++) {
            View view2 = (View) focusables.get(i5);
            int top = view2.getTop();
            int bottom = view2.getBottom();
            int left = view2.getLeft();
            int right = view2.getRight();
            if (i < bottom && top < i2 && i3 < right && left < i4) {
                boolean z4 = i < top && bottom < i2 && i3 < left && right < i4;
                if (view == null) {
                    view = view2;
                    z3 = z4;
                } else {
                    boolean z5 = (z && top < view.getTop()) || (!z && bottom > view.getBottom());
                    boolean z6 = (z2 && left < view.getLeft()) || (!z2 && right > view.getRight());
                    if (z3) {
                        if (z4) {
                            if (z5) {
                                if (!z6) {
                                }
                                view = view2;
                            }
                        }
                    } else if (z4) {
                        view = view2;
                        z3 = true;
                    } else if (z5) {
                        if (!z6) {
                        }
                        view = view2;
                    }
                }
            }
        }
        return view;
    }

    private View h(boolean z, int i, boolean z2, int i2, View view) {
        int verticalFadingEdgeLength = getVerticalFadingEdgeLength() / 2;
        int i3 = i + verticalFadingEdgeLength;
        int height = (i + getHeight()) - verticalFadingEdgeLength;
        int horizontalFadingEdgeLength = getHorizontalFadingEdgeLength() / 2;
        int i4 = i2 + horizontalFadingEdgeLength;
        int width = (i2 + getWidth()) - horizontalFadingEdgeLength;
        return (view == null || view.getTop() >= height || view.getBottom() <= i3 || view.getLeft() >= width || view.getRight() <= i4) ? g(z, i3, height, z2, i4, width) : view;
    }

    private void k() {
        this.f1684d = new Scroller(getContext());
        setFocusable(true);
        setDescendantFocusability(262144);
        setWillNotDraw(false);
        ViewConfiguration viewConfiguration = ViewConfiguration.get(getContext());
        this.l = viewConfiguration.getScaledTouchSlop();
        this.m = viewConfiguration.getScaledMinimumFlingVelocity();
        this.n = viewConfiguration.getScaledMaximumFlingVelocity();
    }

    private boolean l(View view, View view2) {
        if (view == view2) {
            return true;
        }
        ViewParent parent = view.getParent();
        return (parent instanceof ViewGroup) && l((View) parent, view2);
    }

    private boolean m(int i, int i2, int i3, int i4, int i5, int i6) {
        boolean z;
        int height = getHeight();
        int scrollY = getScrollY();
        int i7 = scrollY + height;
        boolean z2 = i == 33;
        int width = getWidth();
        int scrollX = getScrollX();
        int i8 = scrollX + width;
        boolean z3 = i4 == 33;
        View g = g(z2, i2, i3, z3, i5, i6);
        if (g == null) {
            g = this;
        }
        if ((i2 < scrollY || i3 > i7) && (i5 < scrollX || i6 > i8)) {
            e(z3 ? i5 - scrollX : i6 - i8, z2 ? i2 - scrollY : i3 - i7);
            z = true;
        } else {
            z = false;
        }
        if (g != findFocus() && g.requestFocus(i)) {
            this.e = true;
            this.e = false;
        }
        return z;
    }

    private void n(View view) {
        view.getDrawingRect(this.f1683c);
        offsetDescendantRectToMyCoords(view, this.f1683c);
        int d2 = d(this.f1683c);
        if (d2 != 0) {
            scrollBy(0, d2);
        }
    }

    private boolean o(Rect rect, boolean z) {
        int d2 = d(rect);
        boolean z2 = d2 != 0;
        if (z2) {
            if (z) {
                scrollBy(0, d2);
            } else {
                p(0, d2);
            }
        }
        return z2;
    }

    public boolean a(int i, boolean z) {
        int bottom;
        int bottom2;
        View findFocus = findFocus();
        if (findFocus == this) {
            findFocus = null;
        }
        View findNextFocus = FocusFinder.getInstance().findNextFocus(this, findFocus, i);
        int maxScrollAmountHorizontal = z ? getMaxScrollAmountHorizontal() : getMaxScrollAmountVertical();
        if (z) {
            if (findNextFocus == null) {
                if (i == 33 && getScrollY() < maxScrollAmountHorizontal) {
                    maxScrollAmountHorizontal = getScrollY();
                } else if (i == 130 && getChildCount() > 0 && (bottom = getChildAt(0).getBottom() - (getScrollY() + getHeight())) < maxScrollAmountHorizontal) {
                    maxScrollAmountHorizontal = bottom;
                }
                if (maxScrollAmountHorizontal == 0) {
                    return false;
                }
                if (i != 130) {
                    maxScrollAmountHorizontal = -maxScrollAmountHorizontal;
                }
                e(maxScrollAmountHorizontal, 0);
                return true;
            }
            findNextFocus.getDrawingRect(this.f1683c);
            offsetDescendantRectToMyCoords(findNextFocus, this.f1683c);
            e(d(this.f1683c), 0);
        } else if (findNextFocus == null) {
            if (i == 33 && getScrollY() < maxScrollAmountHorizontal) {
                maxScrollAmountHorizontal = getScrollY();
            } else if (i == 130 && getChildCount() > 0 && (bottom2 = getChildAt(0).getBottom() - (getScrollY() + getHeight())) < maxScrollAmountHorizontal) {
                maxScrollAmountHorizontal = bottom2;
            }
            if (maxScrollAmountHorizontal == 0) {
                return false;
            }
            if (i != 130) {
                maxScrollAmountHorizontal = -maxScrollAmountHorizontal;
            }
            e(0, maxScrollAmountHorizontal);
            return true;
        } else {
            findNextFocus.getDrawingRect(this.f1683c);
            offsetDescendantRectToMyCoords(findNextFocus, this.f1683c);
            e(0, d(this.f1683c));
        }
        findNextFocus.requestFocus(i);
        return true;
    }

    @Override // android.view.ViewGroup
    public void addView(View view) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("TwoDScrollView can host only one direct child");
        }
        super.addView(view);
    }

    @Override // android.view.ViewGroup
    public void addView(View view, int i) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("TwoDScrollView can host only one direct child");
        }
        super.addView(view, i);
    }

    @Override // android.view.ViewGroup
    public void addView(View view, int i, ViewGroup.LayoutParams layoutParams) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("TwoDScrollView can host only one direct child");
        }
        super.addView(view, i, layoutParams);
    }

    @Override // android.view.ViewGroup, android.view.ViewManager
    public void addView(View view, ViewGroup.LayoutParams layoutParams) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("TwoDScrollView can host only one direct child");
        }
        super.addView(view, layoutParams);
    }

    @Override // android.view.View
    protected int computeHorizontalScrollRange() {
        return getChildCount() == 0 ? getWidth() : getChildAt(0).getRight();
    }

    @Override // android.view.View
    public void computeScroll() {
        if (this.f1684d.computeScrollOffset()) {
            int scrollX = getScrollX();
            int scrollY = getScrollY();
            int currX = this.f1684d.getCurrX();
            int currY = this.f1684d.getCurrY();
            if (getChildCount() > 0) {
                View childAt = getChildAt(0);
                currX = c(currX, (getWidth() - getPaddingRight()) - getPaddingLeft(), childAt.getWidth());
                currY = c(currY, (getHeight() - getPaddingBottom()) - getPaddingTop(), childAt.getHeight());
            }
            scrollTo(currX, currY);
            if (scrollX != getScrollX() || scrollY != getScrollY()) {
                onScrollChanged(getScrollX(), getScrollY(), scrollX, scrollY);
            }
            postInvalidate();
        }
    }

    @Override // android.view.View
    protected int computeVerticalScrollRange() {
        return getChildCount() == 0 ? getHeight() : getChildAt(0).getBottom();
    }

    protected int d(Rect rect) {
        if (getChildCount() == 0) {
            return 0;
        }
        int height = getHeight();
        int scrollY = getScrollY();
        int i = scrollY + height;
        int verticalFadingEdgeLength = getVerticalFadingEdgeLength();
        if (rect.top > 0) {
            scrollY += verticalFadingEdgeLength;
        }
        if (rect.bottom < getChildAt(0).getHeight()) {
            i -= verticalFadingEdgeLength;
        }
        int i2 = rect.bottom;
        if (i2 > i && rect.top > scrollY) {
            return Math.min((rect.height() > height ? rect.top - scrollY : rect.bottom - i) + 0, getChildAt(0).getBottom() - i);
        } else if (rect.top >= scrollY || i2 >= i) {
            return 0;
        } else {
            return Math.max(rect.height() > height ? 0 - (i - rect.bottom) : 0 - (scrollY - rect.top), -getScrollY());
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    public boolean dispatchKeyEvent(KeyEvent keyEvent) {
        if (super.dispatchKeyEvent(keyEvent)) {
            return true;
        }
        return f(keyEvent);
    }

    /* JADX WARN: Code restructure failed: missing block: B:24:0x0046, code lost:
        if (r5.isAltPressed() == false) goto L26;
     */
    /* JADX WARN: Code restructure failed: missing block: B:27:0x004f, code lost:
        if (r5.isAltPressed() == false) goto L26;
     */
    /* JADX WARN: Code restructure failed: missing block: B:41:?, code lost:
        return a(r0, true);
     */
    /* JADX WARN: Code restructure failed: missing block: B:42:?, code lost:
        return j(r0, true);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean f(android.view.KeyEvent r5) {
        /*
            r4 = this;
            android.graphics.Rect r0 = r4.f1683c
            r0.setEmpty()
            boolean r0 = r4.b()
            r1 = 130(0x82, float:1.82E-43)
            r2 = 1
            r3 = 0
            if (r0 != 0) goto L32
            boolean r5 = r4.isFocused()
            if (r5 == 0) goto L31
            android.view.View r5 = r4.findFocus()
            if (r5 != r4) goto L1c
            r5 = 0
        L1c:
            android.view.FocusFinder r0 = android.view.FocusFinder.getInstance()
            android.view.View r5 = r0.findNextFocus(r4, r5, r1)
            if (r5 == 0) goto L2f
            if (r5 == r4) goto L2f
            boolean r5 = r5.requestFocus(r1)
            if (r5 == 0) goto L2f
            goto L30
        L2f:
            r2 = r3
        L30:
            return r2
        L31:
            return r3
        L32:
            int r0 = r5.getAction()
            if (r0 != 0) goto L7c
            int r0 = r5.getKeyCode()
            switch(r0) {
                case 19: goto L6b;
                case 20: goto L5b;
                case 21: goto L49;
                case 22: goto L40;
                default: goto L3f;
            }
        L3f:
            goto L7c
        L40:
            boolean r5 = r5.isAltPressed()
            r0 = 66
            if (r5 != 0) goto L56
            goto L51
        L49:
            boolean r5 = r5.isAltPressed()
            r0 = 17
            if (r5 != 0) goto L56
        L51:
            boolean r3 = r4.a(r0, r2)
            goto L7c
        L56:
            boolean r3 = r4.j(r0, r2)
            goto L7c
        L5b:
            boolean r5 = r5.isAltPressed()
            if (r5 != 0) goto L66
            boolean r3 = r4.a(r1, r3)
            goto L7c
        L66:
            boolean r3 = r4.j(r1, r3)
            goto L7c
        L6b:
            boolean r5 = r5.isAltPressed()
            r0 = 33
            if (r5 != 0) goto L78
            boolean r3 = r4.a(r0, r3)
            goto L7c
        L78:
            boolean r3 = r4.j(r0, r3)
        L7c:
            return r3
        */
        throw new UnsupportedOperationException("Method not decompiled: b.h.a.a.d.c.f(android.view.KeyEvent):boolean");
    }

    @Override // android.view.View
    protected float getBottomFadingEdgeStrength() {
        if (getChildCount() == 0) {
            return 0.0f;
        }
        int verticalFadingEdgeLength = getVerticalFadingEdgeLength();
        int bottom = (getChildAt(0).getBottom() - getScrollY()) - (getHeight() - getPaddingBottom());
        if (bottom < verticalFadingEdgeLength) {
            return bottom / verticalFadingEdgeLength;
        }
        return 1.0f;
    }

    @Override // android.view.View
    protected float getLeftFadingEdgeStrength() {
        if (getChildCount() == 0) {
            return 0.0f;
        }
        int horizontalFadingEdgeLength = getHorizontalFadingEdgeLength();
        if (getScrollX() < horizontalFadingEdgeLength) {
            return getScrollX() / horizontalFadingEdgeLength;
        }
        return 1.0f;
    }

    public int getMaxScrollAmountHorizontal() {
        return (int) (getWidth() * 0.5f);
    }

    public int getMaxScrollAmountVertical() {
        return (int) (getHeight() * 0.5f);
    }

    @Override // android.view.View
    protected float getRightFadingEdgeStrength() {
        if (getChildCount() == 0) {
            return 0.0f;
        }
        int horizontalFadingEdgeLength = getHorizontalFadingEdgeLength();
        int right = (getChildAt(0).getRight() - getScrollX()) - (getWidth() - getPaddingRight());
        if (right < horizontalFadingEdgeLength) {
            return right / horizontalFadingEdgeLength;
        }
        return 1.0f;
    }

    @Override // android.view.View
    protected float getTopFadingEdgeStrength() {
        if (getChildCount() == 0) {
            return 0.0f;
        }
        int verticalFadingEdgeLength = getVerticalFadingEdgeLength();
        if (getScrollY() < verticalFadingEdgeLength) {
            return getScrollY() / verticalFadingEdgeLength;
        }
        return 1.0f;
    }

    public void i(int i, int i2) {
        if (getChildCount() > 0) {
            int height = (getHeight() - getPaddingBottom()) - getPaddingTop();
            int height2 = getChildAt(0).getHeight();
            this.f1684d.fling(getScrollX(), getScrollY(), i, i2, 0, getChildAt(0).getWidth() - ((getWidth() - getPaddingRight()) - getPaddingLeft()), 0, height2 - height);
            boolean z = i2 > 0;
            View h = h(i > 0, this.f1684d.getFinalX(), z, this.f1684d.getFinalY(), findFocus());
            if (h == null) {
                h = this;
            }
            if (h != findFocus()) {
                if (h.requestFocus(z ? 130 : 33)) {
                    this.e = true;
                    this.e = false;
                }
            }
            awakenScrollBars(this.f1684d.getDuration());
            invalidate();
        }
    }

    public boolean j(int i, boolean z) {
        int childCount;
        int childCount2;
        if (z) {
            boolean z2 = i == 130;
            int width = getWidth();
            Rect rect = this.f1683c;
            rect.left = 0;
            rect.right = width;
            if (z2 && (childCount = getChildCount()) > 0) {
                this.f1683c.right = getChildAt(childCount - 1).getBottom();
                Rect rect2 = this.f1683c;
                rect2.left = rect2.right - width;
            }
            Rect rect3 = this.f1683c;
            return m(0, 0, 0, i, rect3.top, rect3.bottom);
        }
        boolean z3 = i == 130;
        int height = getHeight();
        Rect rect4 = this.f1683c;
        rect4.top = 0;
        rect4.bottom = height;
        if (z3 && (childCount2 = getChildCount()) > 0) {
            this.f1683c.bottom = getChildAt(childCount2 - 1).getBottom();
            Rect rect5 = this.f1683c;
            rect5.top = rect5.bottom - height;
        }
        Rect rect6 = this.f1683c;
        return m(i, rect6.top, rect6.bottom, 0, 0, 0);
    }

    @Override // android.view.ViewGroup
    protected void measureChild(View view, int i, int i2) {
        view.measure(FrameLayout.getChildMeasureSpec(i, getPaddingLeft() + getPaddingRight(), view.getLayoutParams().width), View.MeasureSpec.makeMeasureSpec(0, 0));
    }

    @Override // android.view.ViewGroup
    protected void measureChildWithMargins(View view, int i, int i2, int i3, int i4) {
        ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) view.getLayoutParams();
        view.measure(View.MeasureSpec.makeMeasureSpec(marginLayoutParams.leftMargin + marginLayoutParams.rightMargin, 0), View.MeasureSpec.makeMeasureSpec(marginLayoutParams.topMargin + marginLayoutParams.bottomMargin, 0));
    }

    /* JADX WARN: Code restructure failed: missing block: B:16:0x0026, code lost:
        if (r0 != 3) goto L17;
     */
    @Override // android.view.ViewGroup
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean onInterceptTouchEvent(android.view.MotionEvent r6) {
        /*
            r5 = this;
            int r0 = r6.getAction()
            r1 = 2
            r2 = 1
            if (r0 != r1) goto Ld
            boolean r3 = r5.j
            if (r3 == 0) goto Ld
            return r2
        Ld:
            boolean r3 = r5.b()
            r4 = 0
            if (r3 != 0) goto L17
            r5.j = r4
            return r4
        L17:
            float r3 = r6.getY()
            float r6 = r6.getX()
            if (r0 == 0) goto L45
            if (r0 == r2) goto L42
            if (r0 == r1) goto L29
            r6 = 3
            if (r0 == r6) goto L42
            goto L52
        L29:
            float r0 = r5.f
            float r3 = r3 - r0
            float r0 = java.lang.Math.abs(r3)
            int r0 = (int) r0
            float r1 = r5.g
            float r6 = r6 - r1
            float r6 = java.lang.Math.abs(r6)
            int r6 = (int) r6
            int r1 = r5.l
            if (r0 > r1) goto L3f
            if (r6 <= r1) goto L52
        L3f:
            r5.j = r2
            goto L52
        L42:
            r5.j = r4
            goto L52
        L45:
            r5.f = r3
            r5.g = r6
            android.widget.Scroller r6 = r5.f1684d
            boolean r6 = r6.isFinished()
            r6 = r6 ^ r2
            r5.j = r6
        L52:
            boolean r6 = r5.j
            return r6
        */
        throw new UnsupportedOperationException("Method not decompiled: b.h.a.a.d.c.onInterceptTouchEvent(android.view.MotionEvent):boolean");
    }

    @Override // android.widget.FrameLayout, android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        this.h = false;
        View view = this.i;
        if (view != null && l(view, this)) {
            n(this.i);
        }
        this.i = null;
        scrollTo(getScrollX(), getScrollY());
    }

    @Override // android.view.ViewGroup
    protected boolean onRequestFocusInDescendants(int i, Rect rect) {
        if (i == 2) {
            i = 130;
        } else if (i == 1) {
            i = 33;
        }
        FocusFinder focusFinder = FocusFinder.getInstance();
        View findNextFocus = rect == null ? focusFinder.findNextFocus(this, null, i) : focusFinder.findNextFocusFromRect(this, rect, i);
        if (findNextFocus == null) {
            return false;
        }
        return findNextFocus.requestFocus(i, rect);
    }

    @Override // android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        View findFocus = findFocus();
        if (findFocus == null || this == findFocus) {
            return;
        }
        findFocus.getDrawingRect(this.f1683c);
        offsetDescendantRectToMyCoords(findFocus, this.f1683c);
        e(d(this.f1683c), d(this.f1683c));
    }

    /* JADX WARN: Code restructure failed: missing block: B:22:0x004c, code lost:
        if (getScrollX() < 0) goto L22;
     */
    /* JADX WARN: Code restructure failed: missing block: B:30:0x0075, code lost:
        if (getScrollY() < 0) goto L27;
     */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean onTouchEvent(android.view.MotionEvent r7) {
        /*
            Method dump skipped, instructions count: 234
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: b.h.a.a.d.c.onTouchEvent(android.view.MotionEvent):boolean");
    }

    public final void p(int i, int i2) {
        if (AnimationUtils.currentAnimationTimeMillis() - this.f1682b > 250) {
            this.f1684d.startScroll(getScrollX(), getScrollY(), i, i2);
            awakenScrollBars(this.f1684d.getDuration());
            invalidate();
        } else {
            if (!this.f1684d.isFinished()) {
                this.f1684d.abortAnimation();
            }
            scrollBy(i, i2);
        }
        this.f1682b = AnimationUtils.currentAnimationTimeMillis();
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public void requestChildFocus(View view, View view2) {
        if (!this.e) {
            if (this.h) {
                this.i = view2;
            } else {
                n(view2);
            }
        }
        super.requestChildFocus(view, view2);
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public boolean requestChildRectangleOnScreen(View view, Rect rect, boolean z) {
        rect.offset(view.getLeft() - view.getScrollX(), view.getTop() - view.getScrollY());
        return o(rect, z);
    }

    @Override // android.view.View, android.view.ViewParent
    public void requestLayout() {
        this.h = true;
        super.requestLayout();
    }

    @Override // android.view.View
    public void scrollTo(int i, int i2) {
        if (getChildCount() > 0) {
            View childAt = getChildAt(0);
            int c2 = c(i, (getWidth() - getPaddingRight()) - getPaddingLeft(), childAt.getWidth());
            int c3 = c(i2, (getHeight() - getPaddingBottom()) - getPaddingTop(), childAt.getHeight());
            if (c2 == getScrollX() && c3 == getScrollY()) {
                return;
            }
            super.scrollTo(c2, c3);
        }
    }
}
