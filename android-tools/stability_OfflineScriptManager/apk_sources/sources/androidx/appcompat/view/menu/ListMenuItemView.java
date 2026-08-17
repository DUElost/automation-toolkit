package androidx.appcompat.view.menu;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;
import androidx.appcompat.view.menu.p;
import androidx.appcompat.widget.q0;
/* loaded from: classes.dex */
public class ListMenuItemView extends LinearLayout implements p.a, AbsListView.SelectionBoundsAdjuster {

    /* renamed from: b  reason: collision with root package name */
    private j f524b;

    /* renamed from: c  reason: collision with root package name */
    private ImageView f525c;

    /* renamed from: d  reason: collision with root package name */
    private RadioButton f526d;
    private TextView e;
    private CheckBox f;
    private TextView g;
    private ImageView h;
    private ImageView i;
    private LinearLayout j;
    private Drawable k;
    private int l;
    private Context m;
    private boolean n;
    private Drawable o;
    private boolean p;
    private LayoutInflater q;
    private boolean r;

    public ListMenuItemView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.a.a.listMenuViewStyle);
    }

    public ListMenuItemView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet);
        q0 t = q0.t(getContext(), attributeSet, a.a.j.MenuView, i, 0);
        this.k = t.f(a.a.j.MenuView_android_itemBackground);
        this.l = t.m(a.a.j.MenuView_android_itemTextAppearance, -1);
        this.n = t.a(a.a.j.MenuView_preserveIconSpacing, false);
        this.m = context;
        this.o = t.f(a.a.j.MenuView_subMenuArrow);
        TypedArray obtainStyledAttributes = context.getTheme().obtainStyledAttributes(null, new int[]{16843049}, a.a.a.dropDownListViewStyle, 0);
        this.p = obtainStyledAttributes.hasValue(0);
        t.u();
        obtainStyledAttributes.recycle();
    }

    private void a(View view) {
        b(view, -1);
    }

    private void b(View view, int i) {
        LinearLayout linearLayout = this.j;
        if (linearLayout != null) {
            linearLayout.addView(view, i);
        } else {
            addView(view, i);
        }
    }

    private void c() {
        CheckBox checkBox = (CheckBox) getInflater().inflate(a.a.g.abc_list_menu_item_checkbox, (ViewGroup) this, false);
        this.f = checkBox;
        a(checkBox);
    }

    private void f() {
        ImageView imageView = (ImageView) getInflater().inflate(a.a.g.abc_list_menu_item_icon, (ViewGroup) this, false);
        this.f525c = imageView;
        b(imageView, 0);
    }

    private void g() {
        RadioButton radioButton = (RadioButton) getInflater().inflate(a.a.g.abc_list_menu_item_radio, (ViewGroup) this, false);
        this.f526d = radioButton;
        a(radioButton);
    }

    private LayoutInflater getInflater() {
        if (this.q == null) {
            this.q = LayoutInflater.from(getContext());
        }
        return this.q;
    }

    private void setSubMenuArrowVisible(boolean z) {
        ImageView imageView = this.h;
        if (imageView != null) {
            imageView.setVisibility(z ? 0 : 8);
        }
    }

    @Override // android.widget.AbsListView.SelectionBoundsAdjuster
    public void adjustListItemSelectionBounds(Rect rect) {
        ImageView imageView = this.i;
        if (imageView == null || imageView.getVisibility() != 0) {
            return;
        }
        LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) this.i.getLayoutParams();
        rect.top += this.i.getHeight() + layoutParams.topMargin + layoutParams.bottomMargin;
    }

    @Override // androidx.appcompat.view.menu.p.a
    public boolean d() {
        return false;
    }

    @Override // androidx.appcompat.view.menu.p.a
    public void e(j jVar, int i) {
        this.f524b = jVar;
        setVisibility(jVar.isVisible() ? 0 : 8);
        setTitle(jVar.i(this));
        setCheckable(jVar.isCheckable());
        h(jVar.A(), jVar.g());
        setIcon(jVar.getIcon());
        setEnabled(jVar.isEnabled());
        setSubMenuArrowVisible(jVar.hasSubMenu());
        setContentDescription(jVar.getContentDescription());
    }

    @Override // androidx.appcompat.view.menu.p.a
    public j getItemData() {
        return this.f524b;
    }

    public void h(boolean z, char c2) {
        int i = (z && this.f524b.A()) ? 0 : 8;
        if (i == 0) {
            this.g.setText(this.f524b.h());
        }
        if (this.g.getVisibility() != i) {
            this.g.setVisibility(i);
        }
    }

    @Override // android.view.View
    protected void onFinishInflate() {
        super.onFinishInflate();
        a.f.l.r.Q(this, this.k);
        TextView textView = (TextView) findViewById(a.a.f.title);
        this.e = textView;
        int i = this.l;
        if (i != -1) {
            textView.setTextAppearance(this.m, i);
        }
        this.g = (TextView) findViewById(a.a.f.shortcut);
        ImageView imageView = (ImageView) findViewById(a.a.f.submenuarrow);
        this.h = imageView;
        if (imageView != null) {
            imageView.setImageDrawable(this.o);
        }
        this.i = (ImageView) findViewById(a.a.f.group_divider);
        this.j = (LinearLayout) findViewById(a.a.f.content);
    }

    @Override // android.widget.LinearLayout, android.view.View
    protected void onMeasure(int i, int i2) {
        if (this.f525c != null && this.n) {
            ViewGroup.LayoutParams layoutParams = getLayoutParams();
            LinearLayout.LayoutParams layoutParams2 = (LinearLayout.LayoutParams) this.f525c.getLayoutParams();
            int i3 = layoutParams.height;
            if (i3 > 0 && layoutParams2.width <= 0) {
                layoutParams2.width = i3;
            }
        }
        super.onMeasure(i, i2);
    }

    public void setCheckable(boolean z) {
        CompoundButton compoundButton;
        CompoundButton compoundButton2;
        if (!z && this.f526d == null && this.f == null) {
            return;
        }
        if (this.f524b.m()) {
            if (this.f526d == null) {
                g();
            }
            compoundButton = this.f526d;
            compoundButton2 = this.f;
        } else {
            if (this.f == null) {
                c();
            }
            compoundButton = this.f;
            compoundButton2 = this.f526d;
        }
        if (z) {
            compoundButton.setChecked(this.f524b.isChecked());
            if (compoundButton.getVisibility() != 0) {
                compoundButton.setVisibility(0);
            }
            if (compoundButton2 == null || compoundButton2.getVisibility() == 8) {
                return;
            }
            compoundButton2.setVisibility(8);
            return;
        }
        CheckBox checkBox = this.f;
        if (checkBox != null) {
            checkBox.setVisibility(8);
        }
        RadioButton radioButton = this.f526d;
        if (radioButton != null) {
            radioButton.setVisibility(8);
        }
    }

    public void setChecked(boolean z) {
        CompoundButton compoundButton;
        if (this.f524b.m()) {
            if (this.f526d == null) {
                g();
            }
            compoundButton = this.f526d;
        } else {
            if (this.f == null) {
                c();
            }
            compoundButton = this.f;
        }
        compoundButton.setChecked(z);
    }

    public void setForceShowIcon(boolean z) {
        this.r = z;
        this.n = z;
    }

    public void setGroupDividerEnabled(boolean z) {
        ImageView imageView = this.i;
        if (imageView != null) {
            imageView.setVisibility((this.p || !z) ? 8 : 0);
        }
    }

    public void setIcon(Drawable drawable) {
        boolean z = this.f524b.z() || this.r;
        if (z || this.n) {
            ImageView imageView = this.f525c;
            if (imageView == null && drawable == null && !this.n) {
                return;
            }
            if (imageView == null) {
                f();
            }
            if (drawable == null && !this.n) {
                this.f525c.setVisibility(8);
                return;
            }
            ImageView imageView2 = this.f525c;
            if (!z) {
                drawable = null;
            }
            imageView2.setImageDrawable(drawable);
            if (this.f525c.getVisibility() != 0) {
                this.f525c.setVisibility(0);
            }
        }
    }

    public void setTitle(CharSequence charSequence) {
        int i;
        TextView textView;
        if (charSequence != null) {
            this.e.setText(charSequence);
            if (this.e.getVisibility() == 0) {
                return;
            }
            textView = this.e;
            i = 0;
        } else {
            i = 8;
            if (this.e.getVisibility() == 8) {
                return;
            }
            textView = this.e;
        }
        textView.setVisibility(i);
    }
}
