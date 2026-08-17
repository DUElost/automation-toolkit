package a.n.a.a;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.ArgbEvaluator;
import android.animation.ObjectAnimator;
import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.PorterDuff;
import android.graphics.Rect;
import android.graphics.drawable.Animatable;
import android.graphics.drawable.AnimatedVectorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import java.util.ArrayList;
import org.xmlpull.v1.XmlPullParser;
/* loaded from: classes.dex */
public class b extends g implements Animatable {

    /* renamed from: c  reason: collision with root package name */
    private C0019b f333c;

    /* renamed from: d  reason: collision with root package name */
    private Context f334d;
    private ArgbEvaluator e;
    final Drawable.Callback f;

    /* loaded from: classes.dex */
    class a implements Drawable.Callback {
        a() {
        }

        @Override // android.graphics.drawable.Drawable.Callback
        public void invalidateDrawable(Drawable drawable) {
            b.this.invalidateSelf();
        }

        @Override // android.graphics.drawable.Drawable.Callback
        public void scheduleDrawable(Drawable drawable, Runnable runnable, long j) {
            b.this.scheduleSelf(runnable, j);
        }

        @Override // android.graphics.drawable.Drawable.Callback
        public void unscheduleDrawable(Drawable drawable, Runnable runnable) {
            b.this.unscheduleSelf(runnable);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: a.n.a.a.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0019b extends Drawable.ConstantState {

        /* renamed from: a  reason: collision with root package name */
        int f336a;

        /* renamed from: b  reason: collision with root package name */
        h f337b;

        /* renamed from: c  reason: collision with root package name */
        AnimatorSet f338c;

        /* renamed from: d  reason: collision with root package name */
        ArrayList<Animator> f339d;
        a.d.a<Animator, String> e;

        public C0019b(Context context, C0019b c0019b, Drawable.Callback callback, Resources resources) {
            if (c0019b != null) {
                this.f336a = c0019b.f336a;
                h hVar = c0019b.f337b;
                if (hVar != null) {
                    Drawable.ConstantState constantState = hVar.getConstantState();
                    this.f337b = (h) (resources != null ? constantState.newDrawable(resources) : constantState.newDrawable());
                    h hVar2 = this.f337b;
                    hVar2.mutate();
                    h hVar3 = hVar2;
                    this.f337b = hVar3;
                    hVar3.setCallback(callback);
                    this.f337b.setBounds(c0019b.f337b.getBounds());
                    this.f337b.h(false);
                }
                ArrayList<Animator> arrayList = c0019b.f339d;
                if (arrayList != null) {
                    int size = arrayList.size();
                    this.f339d = new ArrayList<>(size);
                    this.e = new a.d.a<>(size);
                    for (int i = 0; i < size; i++) {
                        Animator animator = c0019b.f339d.get(i);
                        Animator clone = animator.clone();
                        String str = c0019b.e.get(animator);
                        clone.setTarget(this.f337b.d(str));
                        this.f339d.add(clone);
                        this.e.put(clone, str);
                    }
                    a();
                }
            }
        }

        public void a() {
            if (this.f338c == null) {
                this.f338c = new AnimatorSet();
            }
            this.f338c.playTogether(this.f339d);
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public int getChangingConfigurations() {
            return this.f336a;
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable() {
            throw new IllegalStateException("No constant state support for SDK < 24.");
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable(Resources resources) {
            throw new IllegalStateException("No constant state support for SDK < 24.");
        }
    }

    /* loaded from: classes.dex */
    private static class c extends Drawable.ConstantState {

        /* renamed from: a  reason: collision with root package name */
        private final Drawable.ConstantState f340a;

        public c(Drawable.ConstantState constantState) {
            this.f340a = constantState;
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public boolean canApplyTheme() {
            return this.f340a.canApplyTheme();
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public int getChangingConfigurations() {
            return this.f340a.getChangingConfigurations();
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable() {
            b bVar = new b();
            Drawable newDrawable = this.f340a.newDrawable();
            bVar.f345b = newDrawable;
            newDrawable.setCallback(bVar.f);
            return bVar;
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable(Resources resources) {
            b bVar = new b();
            Drawable newDrawable = this.f340a.newDrawable(resources);
            bVar.f345b = newDrawable;
            newDrawable.setCallback(bVar.f);
            return bVar;
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable(Resources resources, Resources.Theme theme) {
            b bVar = new b();
            Drawable newDrawable = this.f340a.newDrawable(resources, theme);
            bVar.f345b = newDrawable;
            newDrawable.setCallback(bVar.f);
            return bVar;
        }
    }

    b() {
        this(null, null, null);
    }

    private b(Context context) {
        this(context, null, null);
    }

    private b(Context context, C0019b c0019b, Resources resources) {
        this.e = null;
        a aVar = new a();
        this.f = aVar;
        this.f334d = context;
        if (c0019b != null) {
            this.f333c = c0019b;
        } else {
            this.f333c = new C0019b(context, c0019b, aVar, resources);
        }
    }

    public static b a(Context context, Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        b bVar = new b(context);
        bVar.inflate(resources, xmlPullParser, attributeSet, theme);
        return bVar;
    }

    private void b(String str, Animator animator) {
        animator.setTarget(this.f333c.f337b.d(str));
        if (Build.VERSION.SDK_INT < 21) {
            c(animator);
        }
        C0019b c0019b = this.f333c;
        if (c0019b.f339d == null) {
            c0019b.f339d = new ArrayList<>();
            this.f333c.e = new a.d.a<>();
        }
        this.f333c.f339d.add(animator);
        this.f333c.e.put(animator, str);
    }

    private void c(Animator animator) {
        ArrayList<Animator> childAnimations;
        if ((animator instanceof AnimatorSet) && (childAnimations = ((AnimatorSet) animator).getChildAnimations()) != null) {
            for (int i = 0; i < childAnimations.size(); i++) {
                c(childAnimations.get(i));
            }
        }
        if (animator instanceof ObjectAnimator) {
            ObjectAnimator objectAnimator = (ObjectAnimator) animator;
            String propertyName = objectAnimator.getPropertyName();
            if ("fillColor".equals(propertyName) || "strokeColor".equals(propertyName)) {
                if (this.e == null) {
                    this.e = new ArgbEvaluator();
                }
                objectAnimator.setEvaluator(this.e);
            }
        }
    }

    @Override // a.n.a.a.g, android.graphics.drawable.Drawable
    public void applyTheme(Resources.Theme theme) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.a(drawable, theme);
        }
    }

    @Override // android.graphics.drawable.Drawable
    public boolean canApplyTheme() {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            return androidx.core.graphics.drawable.a.b(drawable);
        }
        return false;
    }

    @Override // android.graphics.drawable.Drawable
    public void draw(Canvas canvas) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.draw(canvas);
            return;
        }
        this.f333c.f337b.draw(canvas);
        if (this.f333c.f338c.isStarted()) {
            invalidateSelf();
        }
    }

    @Override // android.graphics.drawable.Drawable
    public int getAlpha() {
        Drawable drawable = this.f345b;
        return drawable != null ? androidx.core.graphics.drawable.a.d(drawable) : this.f333c.f337b.getAlpha();
    }

    @Override // android.graphics.drawable.Drawable
    public int getChangingConfigurations() {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.getChangingConfigurations() : super.getChangingConfigurations() | this.f333c.f336a;
    }

    @Override // android.graphics.drawable.Drawable
    public Drawable.ConstantState getConstantState() {
        if (this.f345b == null || Build.VERSION.SDK_INT < 24) {
            return null;
        }
        return new c(this.f345b.getConstantState());
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicHeight() {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.getIntrinsicHeight() : this.f333c.f337b.getIntrinsicHeight();
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicWidth() {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.getIntrinsicWidth() : this.f333c.f337b.getIntrinsicWidth();
    }

    @Override // android.graphics.drawable.Drawable
    public int getOpacity() {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.getOpacity() : this.f333c.f337b.getOpacity();
    }

    @Override // android.graphics.drawable.Drawable
    public void inflate(Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet) {
        inflate(resources, xmlPullParser, attributeSet, null);
    }

    @Override // android.graphics.drawable.Drawable
    public void inflate(Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        TypedArray obtainAttributes;
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.g(drawable, resources, xmlPullParser, attributeSet, theme);
            return;
        }
        int eventType = xmlPullParser.getEventType();
        int depth = xmlPullParser.getDepth() + 1;
        while (eventType != 1 && (xmlPullParser.getDepth() >= depth || eventType != 3)) {
            if (eventType == 2) {
                String name = xmlPullParser.getName();
                if ("animated-vector".equals(name)) {
                    obtainAttributes = androidx.core.content.c.g.i(resources, theme, attributeSet, a.n.a.a.a.e);
                    int resourceId = obtainAttributes.getResourceId(0, 0);
                    if (resourceId != 0) {
                        h b2 = h.b(resources, resourceId, theme);
                        b2.h(false);
                        b2.setCallback(this.f);
                        h hVar = this.f333c.f337b;
                        if (hVar != null) {
                            hVar.setCallback(null);
                        }
                        this.f333c.f337b = b2;
                    }
                } else if ("target".equals(name)) {
                    obtainAttributes = resources.obtainAttributes(attributeSet, a.n.a.a.a.f);
                    String string = obtainAttributes.getString(0);
                    int resourceId2 = obtainAttributes.getResourceId(1, 0);
                    if (resourceId2 != 0) {
                        Context context = this.f334d;
                        if (context == null) {
                            obtainAttributes.recycle();
                            throw new IllegalStateException("Context can't be null when inflating animators");
                        }
                        b(string, d.i(context, resourceId2));
                    }
                } else {
                    continue;
                }
                obtainAttributes.recycle();
            }
            eventType = xmlPullParser.next();
        }
        this.f333c.a();
    }

    @Override // android.graphics.drawable.Drawable
    public boolean isAutoMirrored() {
        Drawable drawable = this.f345b;
        return drawable != null ? androidx.core.graphics.drawable.a.h(drawable) : this.f333c.f337b.isAutoMirrored();
    }

    @Override // android.graphics.drawable.Animatable
    public boolean isRunning() {
        Drawable drawable = this.f345b;
        return drawable != null ? ((AnimatedVectorDrawable) drawable).isRunning() : this.f333c.f338c.isRunning();
    }

    @Override // android.graphics.drawable.Drawable
    public boolean isStateful() {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.isStateful() : this.f333c.f337b.isStateful();
    }

    @Override // android.graphics.drawable.Drawable
    public Drawable mutate() {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.mutate();
        }
        return this;
    }

    @Override // android.graphics.drawable.Drawable
    protected void onBoundsChange(Rect rect) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.setBounds(rect);
        } else {
            this.f333c.f337b.setBounds(rect);
        }
    }

    @Override // a.n.a.a.g, android.graphics.drawable.Drawable
    protected boolean onLevelChange(int i) {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.setLevel(i) : this.f333c.f337b.setLevel(i);
    }

    @Override // android.graphics.drawable.Drawable
    protected boolean onStateChange(int[] iArr) {
        Drawable drawable = this.f345b;
        return drawable != null ? drawable.setState(iArr) : this.f333c.f337b.setState(iArr);
    }

    @Override // android.graphics.drawable.Drawable
    public void setAlpha(int i) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.setAlpha(i);
        } else {
            this.f333c.f337b.setAlpha(i);
        }
    }

    @Override // android.graphics.drawable.Drawable
    public void setAutoMirrored(boolean z) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.j(drawable, z);
        } else {
            this.f333c.f337b.setAutoMirrored(z);
        }
    }

    @Override // android.graphics.drawable.Drawable
    public void setColorFilter(ColorFilter colorFilter) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            drawable.setColorFilter(colorFilter);
        } else {
            this.f333c.f337b.setColorFilter(colorFilter);
        }
    }

    @Override // android.graphics.drawable.Drawable, androidx.core.graphics.drawable.b
    public void setTint(int i) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.n(drawable, i);
        } else {
            this.f333c.f337b.setTint(i);
        }
    }

    @Override // android.graphics.drawable.Drawable, androidx.core.graphics.drawable.b
    public void setTintList(ColorStateList colorStateList) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.o(drawable, colorStateList);
        } else {
            this.f333c.f337b.setTintList(colorStateList);
        }
    }

    @Override // android.graphics.drawable.Drawable, androidx.core.graphics.drawable.b
    public void setTintMode(PorterDuff.Mode mode) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.p(drawable, mode);
        } else {
            this.f333c.f337b.setTintMode(mode);
        }
    }

    @Override // android.graphics.drawable.Drawable
    public boolean setVisible(boolean z, boolean z2) {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            return drawable.setVisible(z, z2);
        }
        this.f333c.f337b.setVisible(z, z2);
        return super.setVisible(z, z2);
    }

    @Override // android.graphics.drawable.Animatable
    public void start() {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            ((AnimatedVectorDrawable) drawable).start();
        } else if (this.f333c.f338c.isStarted()) {
        } else {
            this.f333c.f338c.start();
            invalidateSelf();
        }
    }

    @Override // android.graphics.drawable.Animatable
    public void stop() {
        Drawable drawable = this.f345b;
        if (drawable != null) {
            ((AnimatedVectorDrawable) drawable).stop();
        } else {
            this.f333c.f338c.end();
        }
    }
}
