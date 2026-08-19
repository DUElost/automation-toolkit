package b.a.a;

import android.content.Context;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.graphics.Point;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.os.Build;
import android.text.method.LinkMovementMethod;
import android.text.method.PasswordTransformationMethod;
import android.view.Display;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.ScrollView;
import android.widget.TextView;
import androidx.recyclerview.widget.RecyclerView;
import b.a.a.f;
import com.afollestad.materialdialogs.internal.MDButton;
import com.afollestad.materialdialogs.internal.MDRootLayout;
import java.util.ArrayList;
import java.util.Arrays;
import me.zhanghai.android.materialprogressbar.HorizontalProgressDrawable;
import me.zhanghai.android.materialprogressbar.IndeterminateCircularProgressDrawable;
import me.zhanghai.android.materialprogressbar.IndeterminateHorizontalProgressDrawable;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class d {
    private static void a(ProgressBar progressBar) {
        if (Build.VERSION.SDK_INT >= 18 || !progressBar.isHardwareAccelerated() || progressBar.getLayerType() == 1) {
            return;
        }
        progressBar.setLayerType(1, null);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static int b(f.d dVar) {
        if (dVar.s != null) {
            return l.md_dialog_custom;
        }
        if (dVar.l != null || dVar.X != null) {
            return dVar.w0 != null ? l.md_dialog_list_check : l.md_dialog_list;
        } else if (dVar.k0 > -2) {
            return l.md_dialog_progress;
        } else {
            if (dVar.i0) {
                return dVar.B0 ? l.md_dialog_progress_indeterminate_horizontal : l.md_dialog_progress_indeterminate;
            }
            f.g gVar = dVar.o0;
            CharSequence charSequence = dVar.w0;
            return gVar != null ? charSequence != null ? l.md_dialog_input_check : l.md_dialog_input : charSequence != null ? l.md_dialog_basic_check : l.md_dialog_basic;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static int c(f.d dVar) {
        Context context = dVar.f1321a;
        int i = g.md_dark_theme;
        p pVar = dVar.K;
        p pVar2 = p.DARK;
        boolean k = b.a.a.q.a.k(context, i, pVar == pVar2);
        if (!k) {
            pVar2 = p.LIGHT;
        }
        dVar.K = pVar2;
        return k ? m.MD_Dark : m.MD_Light;
    }

    public static void d(f fVar) {
        boolean k;
        f.l lVar;
        f.d dVar = fVar.f1314d;
        fVar.setCancelable(dVar.L);
        fVar.setCanceledOnTouchOutside(dVar.M);
        if (dVar.g0 == 0) {
            dVar.g0 = b.a.a.q.a.m(dVar.f1321a, g.md_background_color, b.a.a.q.a.l(fVar.getContext(), g.colorBackgroundFloating));
        }
        if (dVar.g0 != 0) {
            GradientDrawable gradientDrawable = new GradientDrawable();
            gradientDrawable.setCornerRadius(dVar.f1321a.getResources().getDimension(i.md_bg_corner_radius));
            gradientDrawable.setColor(dVar.g0);
            fVar.getWindow().setBackgroundDrawable(gradientDrawable);
        }
        if (!dVar.F0) {
            dVar.v = b.a.a.q.a.i(dVar.f1321a, g.md_positive_color, dVar.v);
        }
        if (!dVar.G0) {
            dVar.x = b.a.a.q.a.i(dVar.f1321a, g.md_neutral_color, dVar.x);
        }
        if (!dVar.H0) {
            dVar.w = b.a.a.q.a.i(dVar.f1321a, g.md_negative_color, dVar.w);
        }
        if (!dVar.I0) {
            dVar.t = b.a.a.q.a.m(dVar.f1321a, g.md_widget_color, dVar.t);
        }
        if (!dVar.C0) {
            dVar.i = b.a.a.q.a.m(dVar.f1321a, g.md_title_color, b.a.a.q.a.l(fVar.getContext(), 16842806));
        }
        if (!dVar.D0) {
            dVar.j = b.a.a.q.a.m(dVar.f1321a, g.md_content_color, b.a.a.q.a.l(fVar.getContext(), 16842808));
        }
        if (!dVar.E0) {
            dVar.h0 = b.a.a.q.a.m(dVar.f1321a, g.md_item_color, dVar.j);
        }
        fVar.f = (TextView) fVar.f1308b.findViewById(k.md_title);
        fVar.e = (ImageView) fVar.f1308b.findViewById(k.md_icon);
        fVar.j = fVar.f1308b.findViewById(k.md_titleFrame);
        fVar.g = (TextView) fVar.f1308b.findViewById(k.md_content);
        fVar.i = (RecyclerView) fVar.f1308b.findViewById(k.md_contentRecyclerView);
        fVar.p = (CheckBox) fVar.f1308b.findViewById(k.md_promptCheckbox);
        fVar.q = (MDButton) fVar.f1308b.findViewById(k.md_buttonDefaultPositive);
        fVar.r = (MDButton) fVar.f1308b.findViewById(k.md_buttonDefaultNeutral);
        fVar.s = (MDButton) fVar.f1308b.findViewById(k.md_buttonDefaultNegative);
        if (dVar.o0 != null && dVar.m == null) {
            dVar.m = dVar.f1321a.getText(17039370);
        }
        fVar.q.setVisibility(dVar.m != null ? 0 : 8);
        fVar.r.setVisibility(dVar.n != null ? 0 : 8);
        fVar.s.setVisibility(dVar.o != null ? 0 : 8);
        fVar.q.setFocusable(true);
        fVar.r.setFocusable(true);
        fVar.s.setFocusable(true);
        if (dVar.p) {
            fVar.q.requestFocus();
        }
        if (dVar.q) {
            fVar.r.requestFocus();
        }
        if (dVar.r) {
            fVar.s.requestFocus();
        }
        if (dVar.U != null) {
            fVar.e.setVisibility(0);
            fVar.e.setImageDrawable(dVar.U);
        } else {
            Drawable p = b.a.a.q.a.p(dVar.f1321a, g.md_icon);
            if (p != null) {
                fVar.e.setVisibility(0);
                fVar.e.setImageDrawable(p);
            } else {
                fVar.e.setVisibility(8);
            }
        }
        int i = dVar.W;
        if (i == -1) {
            i = b.a.a.q.a.n(dVar.f1321a, g.md_icon_max_size);
        }
        if (dVar.V || b.a.a.q.a.j(dVar.f1321a, g.md_icon_limit_icon_to_default_size)) {
            i = dVar.f1321a.getResources().getDimensionPixelSize(i.md_icon_max_size);
        }
        if (i > -1) {
            fVar.e.setAdjustViewBounds(true);
            fVar.e.setMaxHeight(i);
            fVar.e.setMaxWidth(i);
            fVar.e.requestLayout();
        }
        if (!dVar.J0) {
            dVar.f0 = b.a.a.q.a.m(dVar.f1321a, g.md_divider_color, b.a.a.q.a.l(fVar.getContext(), g.md_divider));
        }
        fVar.f1308b.setDividerColor(dVar.f0);
        TextView textView = fVar.f;
        if (textView != null) {
            fVar.p(textView, dVar.T);
            fVar.f.setTextColor(dVar.i);
            fVar.f.setGravity(dVar.f1323c.a());
            if (Build.VERSION.SDK_INT >= 17) {
                fVar.f.setTextAlignment(dVar.f1323c.b());
            }
            CharSequence charSequence = dVar.f1322b;
            if (charSequence == null) {
                fVar.j.setVisibility(8);
            } else {
                fVar.f.setText(charSequence);
                fVar.j.setVisibility(0);
            }
        }
        TextView textView2 = fVar.g;
        if (textView2 != null) {
            textView2.setMovementMethod(new LinkMovementMethod());
            fVar.p(fVar.g, dVar.S);
            fVar.g.setLineSpacing(0.0f, dVar.N);
            ColorStateList colorStateList = dVar.y;
            if (colorStateList == null) {
                fVar.g.setLinkTextColor(b.a.a.q.a.l(fVar.getContext(), 16842806));
            } else {
                fVar.g.setLinkTextColor(colorStateList);
            }
            fVar.g.setTextColor(dVar.j);
            fVar.g.setGravity(dVar.f1324d.a());
            if (Build.VERSION.SDK_INT >= 17) {
                fVar.g.setTextAlignment(dVar.f1324d.b());
            }
            CharSequence charSequence2 = dVar.k;
            if (charSequence2 != null) {
                fVar.g.setText(charSequence2);
                fVar.g.setVisibility(0);
            } else {
                fVar.g.setVisibility(8);
            }
        }
        CheckBox checkBox = fVar.p;
        if (checkBox != null) {
            checkBox.setText(dVar.w0);
            fVar.p.setChecked(dVar.x0);
            fVar.p.setOnCheckedChangeListener(dVar.y0);
            fVar.p(fVar.p, dVar.S);
            fVar.p.setTextColor(dVar.j);
            com.afollestad.materialdialogs.internal.c.c(fVar.p, dVar.t);
        }
        fVar.f1308b.setButtonGravity(dVar.g);
        fVar.f1308b.setButtonStackedGravity(dVar.e);
        fVar.f1308b.setStackingBehavior(dVar.d0);
        if (Build.VERSION.SDK_INT < 14 || (k = b.a.a.q.a.k(dVar.f1321a, 16843660, true))) {
            k = b.a.a.q.a.k(dVar.f1321a, g.textAllCaps, true);
        }
        MDButton mDButton = fVar.q;
        fVar.p(mDButton, dVar.T);
        mDButton.setAllCapsCompat(k);
        mDButton.setText(dVar.m);
        mDButton.setTextColor(dVar.v);
        MDButton mDButton2 = fVar.q;
        b bVar = b.POSITIVE;
        mDButton2.setStackedSelector(fVar.g(bVar, true));
        fVar.q.setDefaultSelector(fVar.g(bVar, false));
        fVar.q.setTag(bVar);
        fVar.q.setOnClickListener(fVar);
        fVar.q.setVisibility(0);
        MDButton mDButton3 = fVar.s;
        fVar.p(mDButton3, dVar.T);
        mDButton3.setAllCapsCompat(k);
        mDButton3.setText(dVar.o);
        mDButton3.setTextColor(dVar.w);
        MDButton mDButton4 = fVar.s;
        b bVar2 = b.NEGATIVE;
        mDButton4.setStackedSelector(fVar.g(bVar2, true));
        fVar.s.setDefaultSelector(fVar.g(bVar2, false));
        fVar.s.setTag(bVar2);
        fVar.s.setOnClickListener(fVar);
        fVar.s.setVisibility(0);
        MDButton mDButton5 = fVar.r;
        fVar.p(mDButton5, dVar.T);
        mDButton5.setAllCapsCompat(k);
        mDButton5.setText(dVar.n);
        mDButton5.setTextColor(dVar.x);
        MDButton mDButton6 = fVar.r;
        b bVar3 = b.NEUTRAL;
        mDButton6.setStackedSelector(fVar.g(bVar3, true));
        fVar.r.setDefaultSelector(fVar.g(bVar3, false));
        fVar.r.setTag(bVar3);
        fVar.r.setOnClickListener(fVar);
        fVar.r.setVisibility(0);
        if (dVar.H != null) {
            fVar.u = new ArrayList();
        }
        if (fVar.i != null) {
            RecyclerView.g<?> gVar = dVar.X;
            if (gVar == null) {
                if (dVar.G != null) {
                    lVar = f.l.SINGLE;
                } else if (dVar.H != null) {
                    fVar.t = f.l.MULTI;
                    if (dVar.P != null) {
                        fVar.u = new ArrayList(Arrays.asList(dVar.P));
                        dVar.P = null;
                    }
                    dVar.X = new a(fVar, f.l.a(fVar.t));
                } else {
                    lVar = f.l.REGULAR;
                }
                fVar.t = lVar;
                dVar.X = new a(fVar, f.l.a(fVar.t));
            } else if (gVar instanceof com.afollestad.materialdialogs.internal.b) {
                ((com.afollestad.materialdialogs.internal.b) gVar).a(fVar);
            }
        }
        f(fVar);
        e(fVar);
        if (dVar.s != null) {
            ((MDRootLayout) fVar.f1308b.findViewById(k.md_root)).t();
            FrameLayout frameLayout = (FrameLayout) fVar.f1308b.findViewById(k.md_customViewFrame);
            fVar.k = frameLayout;
            View view = dVar.s;
            if (view.getParent() != null) {
                ((ViewGroup) view.getParent()).removeView(view);
            }
            if (dVar.e0) {
                Resources resources = fVar.getContext().getResources();
                int dimensionPixelSize = resources.getDimensionPixelSize(i.md_dialog_frame_margin);
                ScrollView scrollView = new ScrollView(fVar.getContext());
                int dimensionPixelSize2 = resources.getDimensionPixelSize(i.md_content_padding_top);
                int dimensionPixelSize3 = resources.getDimensionPixelSize(i.md_content_padding_bottom);
                scrollView.setClipToPadding(false);
                if (view instanceof EditText) {
                    scrollView.setPadding(dimensionPixelSize, dimensionPixelSize2, dimensionPixelSize, dimensionPixelSize3);
                } else {
                    scrollView.setPadding(0, dimensionPixelSize2, 0, dimensionPixelSize3);
                    view.setPadding(dimensionPixelSize, 0, dimensionPixelSize, 0);
                }
                scrollView.addView(view, new FrameLayout.LayoutParams(-1, -2));
                view = scrollView;
            }
            frameLayout.addView(view, new ViewGroup.LayoutParams(-1, -2));
        }
        DialogInterface.OnShowListener onShowListener = dVar.c0;
        if (onShowListener != null) {
            fVar.setOnShowListener(onShowListener);
        }
        DialogInterface.OnCancelListener onCancelListener = dVar.a0;
        if (onCancelListener != null) {
            fVar.setOnCancelListener(onCancelListener);
        }
        DialogInterface.OnDismissListener onDismissListener = dVar.Z;
        if (onDismissListener != null) {
            fVar.setOnDismissListener(onDismissListener);
        }
        DialogInterface.OnKeyListener onKeyListener = dVar.b0;
        if (onKeyListener != null) {
            fVar.setOnKeyListener(onKeyListener);
        }
        fVar.b();
        fVar.l();
        fVar.c(fVar.f1308b);
        fVar.d();
        Display defaultDisplay = fVar.getWindow().getWindowManager().getDefaultDisplay();
        Point point = new Point();
        defaultDisplay.getSize(point);
        int i2 = point.x;
        int i3 = point.y;
        int dimensionPixelSize4 = dVar.f1321a.getResources().getDimensionPixelSize(i.md_dialog_vertical_margin);
        int dimensionPixelSize5 = dVar.f1321a.getResources().getDimensionPixelSize(i.md_dialog_horizontal_margin);
        fVar.f1308b.setMaxHeight(i3 - (dimensionPixelSize4 * 2));
        WindowManager.LayoutParams layoutParams = new WindowManager.LayoutParams();
        layoutParams.copyFrom(fVar.getWindow().getAttributes());
        layoutParams.width = Math.min(dVar.f1321a.getResources().getDimensionPixelSize(i.md_dialog_max_width), i2 - (dimensionPixelSize5 * 2));
        fVar.getWindow().setAttributes(layoutParams);
    }

    private static void e(f fVar) {
        f.d dVar = fVar.f1314d;
        EditText editText = (EditText) fVar.f1308b.findViewById(16908297);
        fVar.h = editText;
        if (editText == null) {
            return;
        }
        fVar.p(editText, dVar.S);
        CharSequence charSequence = dVar.m0;
        if (charSequence != null) {
            fVar.h.setText(charSequence);
        }
        fVar.o();
        fVar.h.setHint(dVar.n0);
        fVar.h.setSingleLine();
        fVar.h.setTextColor(dVar.j);
        fVar.h.setHintTextColor(b.a.a.q.a.a(dVar.j, 0.3f));
        com.afollestad.materialdialogs.internal.c.e(fVar.h, fVar.f1314d.t);
        int i = dVar.q0;
        if (i != -1) {
            fVar.h.setInputType(i);
            int i2 = dVar.q0;
            if (i2 != 144 && (i2 & 128) == 128) {
                fVar.h.setTransformationMethod(PasswordTransformationMethod.getInstance());
            }
        }
        TextView textView = (TextView) fVar.f1308b.findViewById(k.md_minMax);
        fVar.o = textView;
        if (dVar.s0 > 0 || dVar.t0 > -1) {
            fVar.k(fVar.h.getText().toString().length(), !dVar.p0);
            return;
        }
        textView.setVisibility(8);
        fVar.o = null;
    }

    /* JADX WARN: Multi-variable type inference failed */
    private static void f(f fVar) {
        HorizontalProgressDrawable horizontalProgressDrawable;
        f.d dVar = fVar.f1314d;
        if (dVar.i0 || dVar.k0 > -2) {
            ProgressBar progressBar = (ProgressBar) fVar.f1308b.findViewById(16908301);
            fVar.l = progressBar;
            if (progressBar == null) {
                return;
            }
            if (Build.VERSION.SDK_INT >= 14) {
                if (!dVar.i0) {
                    HorizontalProgressDrawable horizontalProgressDrawable2 = new HorizontalProgressDrawable(dVar.e());
                    horizontalProgressDrawable2.setTint(dVar.t);
                    horizontalProgressDrawable = horizontalProgressDrawable2;
                } else if (dVar.B0) {
                    IndeterminateHorizontalProgressDrawable indeterminateHorizontalProgressDrawable = new IndeterminateHorizontalProgressDrawable(dVar.e());
                    indeterminateHorizontalProgressDrawable.setTint(dVar.t);
                    horizontalProgressDrawable = indeterminateHorizontalProgressDrawable;
                } else {
                    IndeterminateCircularProgressDrawable indeterminateCircularProgressDrawable = new IndeterminateCircularProgressDrawable(dVar.e());
                    indeterminateCircularProgressDrawable.setTint(dVar.t);
                    horizontalProgressDrawable = indeterminateCircularProgressDrawable;
                }
                fVar.l.setProgressDrawable(horizontalProgressDrawable);
                fVar.l.setIndeterminateDrawable(horizontalProgressDrawable);
            } else {
                com.afollestad.materialdialogs.internal.c.f(progressBar, dVar.t);
            }
            boolean z = dVar.i0;
            if (!z || dVar.B0) {
                fVar.l.setIndeterminate(z && dVar.B0);
                fVar.l.setProgress(0);
                fVar.l.setMax(dVar.l0);
                TextView textView = (TextView) fVar.f1308b.findViewById(k.md_label);
                fVar.m = textView;
                if (textView != null) {
                    textView.setTextColor(dVar.j);
                    fVar.p(fVar.m, dVar.T);
                    fVar.m.setText(dVar.A0.format(0L));
                }
                TextView textView2 = (TextView) fVar.f1308b.findViewById(k.md_minMax);
                fVar.n = textView2;
                if (textView2 != null) {
                    textView2.setTextColor(dVar.j);
                    fVar.p(fVar.n, dVar.S);
                    if (dVar.j0) {
                        fVar.n.setVisibility(0);
                        fVar.n.setText(String.format(dVar.z0, 0, Integer.valueOf(dVar.l0)));
                        ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) fVar.l.getLayoutParams();
                        marginLayoutParams.leftMargin = 0;
                        marginLayoutParams.rightMargin = 0;
                    } else {
                        fVar.n.setVisibility(8);
                    }
                } else {
                    dVar.j0 = false;
                }
            }
        }
        ProgressBar progressBar2 = fVar.l;
        if (progressBar2 != null) {
            a(progressBar2);
        }
    }
}
