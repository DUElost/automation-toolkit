package a.f.j;

import a.f.k.c;
import android.os.Build;
import android.text.PrecomputedText;
import android.text.Spannable;
import android.text.TextDirectionHeuristic;
import android.text.TextDirectionHeuristics;
import android.text.TextPaint;
import android.text.TextUtils;
import android.text.style.MetricAffectingSpan;
/* loaded from: classes.dex */
public class a implements Spannable {

    /* renamed from: b  reason: collision with root package name */
    private final Spannable f155b;

    /* renamed from: c  reason: collision with root package name */
    private final C0008a f156c;

    /* renamed from: d  reason: collision with root package name */
    private final PrecomputedText f157d;

    /* renamed from: a.f.j.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static final class C0008a {

        /* renamed from: a  reason: collision with root package name */
        private final TextPaint f158a;

        /* renamed from: b  reason: collision with root package name */
        private final TextDirectionHeuristic f159b;

        /* renamed from: c  reason: collision with root package name */
        private final int f160c;

        /* renamed from: d  reason: collision with root package name */
        private final int f161d;
        final PrecomputedText.Params e;

        /* renamed from: a.f.j.a$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        public static class C0009a {

            /* renamed from: a  reason: collision with root package name */
            private final TextPaint f162a;

            /* renamed from: b  reason: collision with root package name */
            private TextDirectionHeuristic f163b;

            /* renamed from: c  reason: collision with root package name */
            private int f164c;

            /* renamed from: d  reason: collision with root package name */
            private int f165d;

            public C0009a(TextPaint textPaint) {
                this.f162a = textPaint;
                int i = Build.VERSION.SDK_INT;
                if (i >= 23) {
                    this.f164c = 1;
                    this.f165d = 1;
                } else {
                    this.f165d = 0;
                    this.f164c = 0;
                }
                this.f163b = i >= 18 ? TextDirectionHeuristics.FIRSTSTRONG_LTR : null;
            }

            public C0008a a() {
                return new C0008a(this.f162a, this.f163b, this.f164c, this.f165d);
            }

            public C0009a b(int i) {
                this.f164c = i;
                return this;
            }

            public C0009a c(int i) {
                this.f165d = i;
                return this;
            }

            public C0009a d(TextDirectionHeuristic textDirectionHeuristic) {
                this.f163b = textDirectionHeuristic;
                return this;
            }
        }

        public C0008a(PrecomputedText.Params params) {
            this.f158a = params.getTextPaint();
            this.f159b = params.getTextDirection();
            this.f160c = params.getBreakStrategy();
            this.f161d = params.getHyphenationFrequency();
            this.e = params;
        }

        C0008a(TextPaint textPaint, TextDirectionHeuristic textDirectionHeuristic, int i, int i2) {
            this.e = Build.VERSION.SDK_INT >= 28 ? new PrecomputedText.Params.Builder(textPaint).setBreakStrategy(i).setHyphenationFrequency(i2).setTextDirection(textDirectionHeuristic).build() : null;
            this.f158a = textPaint;
            this.f159b = textDirectionHeuristic;
            this.f160c = i;
            this.f161d = i2;
        }

        public int a() {
            return this.f160c;
        }

        public int b() {
            return this.f161d;
        }

        public TextDirectionHeuristic c() {
            return this.f159b;
        }

        public TextPaint d() {
            return this.f158a;
        }

        public boolean equals(Object obj) {
            if (obj == this) {
                return true;
            }
            if (obj == null || !(obj instanceof C0008a)) {
                return false;
            }
            C0008a c0008a = (C0008a) obj;
            PrecomputedText.Params params = this.e;
            if (params != null) {
                return params.equals(c0008a.e);
            }
            int i = Build.VERSION.SDK_INT;
            if (i < 23 || (this.f160c == c0008a.a() && this.f161d == c0008a.b())) {
                if ((i < 18 || this.f159b == c0008a.c()) && this.f158a.getTextSize() == c0008a.d().getTextSize() && this.f158a.getTextScaleX() == c0008a.d().getTextScaleX() && this.f158a.getTextSkewX() == c0008a.d().getTextSkewX()) {
                    if ((i < 21 || (this.f158a.getLetterSpacing() == c0008a.d().getLetterSpacing() && TextUtils.equals(this.f158a.getFontFeatureSettings(), c0008a.d().getFontFeatureSettings()))) && this.f158a.getFlags() == c0008a.d().getFlags()) {
                        if (i >= 24) {
                            if (!this.f158a.getTextLocales().equals(c0008a.d().getTextLocales())) {
                                return false;
                            }
                        } else if (i >= 17 && !this.f158a.getTextLocale().equals(c0008a.d().getTextLocale())) {
                            return false;
                        }
                        if (this.f158a.getTypeface() == null) {
                            if (c0008a.d().getTypeface() != null) {
                                return false;
                            }
                        } else if (!this.f158a.getTypeface().equals(c0008a.d().getTypeface())) {
                            return false;
                        }
                        return true;
                    }
                    return false;
                }
                return false;
            }
            return false;
        }

        public int hashCode() {
            int i = Build.VERSION.SDK_INT;
            if (i >= 24) {
                return c.b(Float.valueOf(this.f158a.getTextSize()), Float.valueOf(this.f158a.getTextScaleX()), Float.valueOf(this.f158a.getTextSkewX()), Float.valueOf(this.f158a.getLetterSpacing()), Integer.valueOf(this.f158a.getFlags()), this.f158a.getTextLocales(), this.f158a.getTypeface(), Boolean.valueOf(this.f158a.isElegantTextHeight()), this.f159b, Integer.valueOf(this.f160c), Integer.valueOf(this.f161d));
            }
            if (i >= 21) {
                return c.b(Float.valueOf(this.f158a.getTextSize()), Float.valueOf(this.f158a.getTextScaleX()), Float.valueOf(this.f158a.getTextSkewX()), Float.valueOf(this.f158a.getLetterSpacing()), Integer.valueOf(this.f158a.getFlags()), this.f158a.getTextLocale(), this.f158a.getTypeface(), Boolean.valueOf(this.f158a.isElegantTextHeight()), this.f159b, Integer.valueOf(this.f160c), Integer.valueOf(this.f161d));
            }
            if (i < 18 && i < 17) {
                return c.b(Float.valueOf(this.f158a.getTextSize()), Float.valueOf(this.f158a.getTextScaleX()), Float.valueOf(this.f158a.getTextSkewX()), Integer.valueOf(this.f158a.getFlags()), this.f158a.getTypeface(), this.f159b, Integer.valueOf(this.f160c), Integer.valueOf(this.f161d));
            }
            return c.b(Float.valueOf(this.f158a.getTextSize()), Float.valueOf(this.f158a.getTextScaleX()), Float.valueOf(this.f158a.getTextSkewX()), Integer.valueOf(this.f158a.getFlags()), this.f158a.getTextLocale(), this.f158a.getTypeface(), this.f159b, Integer.valueOf(this.f160c), Integer.valueOf(this.f161d));
        }

        /* JADX WARN: Removed duplicated region for block: B:14:0x00df  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public java.lang.String toString() {
            /*
                Method dump skipped, instructions count: 325
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: a.f.j.a.C0008a.toString():java.lang.String");
        }
    }

    public C0008a a() {
        return this.f156c;
    }

    public PrecomputedText b() {
        Spannable spannable = this.f155b;
        if (spannable instanceof PrecomputedText) {
            return (PrecomputedText) spannable;
        }
        return null;
    }

    @Override // java.lang.CharSequence
    public char charAt(int i) {
        return this.f155b.charAt(i);
    }

    @Override // android.text.Spanned
    public int getSpanEnd(Object obj) {
        return this.f155b.getSpanEnd(obj);
    }

    @Override // android.text.Spanned
    public int getSpanFlags(Object obj) {
        return this.f155b.getSpanFlags(obj);
    }

    @Override // android.text.Spanned
    public int getSpanStart(Object obj) {
        return this.f155b.getSpanStart(obj);
    }

    @Override // android.text.Spanned
    public <T> T[] getSpans(int i, int i2, Class<T> cls) {
        return Build.VERSION.SDK_INT >= 28 ? (T[]) this.f157d.getSpans(i, i2, cls) : (T[]) this.f155b.getSpans(i, i2, cls);
    }

    @Override // java.lang.CharSequence
    public int length() {
        return this.f155b.length();
    }

    @Override // android.text.Spanned
    public int nextSpanTransition(int i, int i2, Class cls) {
        return this.f155b.nextSpanTransition(i, i2, cls);
    }

    @Override // android.text.Spannable
    public void removeSpan(Object obj) {
        if (obj instanceof MetricAffectingSpan) {
            throw new IllegalArgumentException("MetricAffectingSpan can not be removed from PrecomputedText.");
        }
        if (Build.VERSION.SDK_INT >= 28) {
            this.f157d.removeSpan(obj);
        } else {
            this.f155b.removeSpan(obj);
        }
    }

    @Override // android.text.Spannable
    public void setSpan(Object obj, int i, int i2, int i3) {
        if (obj instanceof MetricAffectingSpan) {
            throw new IllegalArgumentException("MetricAffectingSpan can not be set to PrecomputedText.");
        }
        if (Build.VERSION.SDK_INT >= 28) {
            this.f157d.setSpan(obj, i, i2, i3);
        } else {
            this.f155b.setSpan(obj, i, i2, i3);
        }
    }

    @Override // java.lang.CharSequence
    public CharSequence subSequence(int i, int i2) {
        return this.f155b.subSequence(i, i2);
    }

    @Override // java.lang.CharSequence
    public String toString() {
        return this.f155b.toString();
    }
}
