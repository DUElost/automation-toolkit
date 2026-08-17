package b.h.a.a.d;

import android.content.Context;
import android.view.ContextThemeWrapper;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
/* loaded from: classes.dex */
public class b extends LinearLayout {

    /* renamed from: b  reason: collision with root package name */
    private LinearLayout f1679b;

    /* renamed from: c  reason: collision with root package name */
    private ViewGroup f1680c;

    /* renamed from: d  reason: collision with root package name */
    private final int f1681d;

    public b(Context context, int i) {
        super(context);
        this.f1681d = i;
        a();
    }

    private void a() {
        setOrientation(1);
        RelativeLayout relativeLayout = new RelativeLayout(getContext());
        this.f1680c = relativeLayout;
        relativeLayout.setLayoutParams(new LinearLayout.LayoutParams(-1, -2));
        this.f1680c.setId(b.h.a.a.a.node_header);
        LinearLayout linearLayout = new LinearLayout(new ContextThemeWrapper(getContext(), this.f1681d), null, this.f1681d);
        this.f1679b = linearLayout;
        linearLayout.setLayoutParams(new LinearLayout.LayoutParams(-1, -2));
        this.f1679b.setId(b.h.a.a.a.node_items);
        this.f1679b.setOrientation(1);
        this.f1679b.setVisibility(8);
        addView(this.f1680c);
        addView(this.f1679b);
    }

    public void b(View view) {
        this.f1680c.addView(view);
    }

    public ViewGroup getNodeContainer() {
        return this.f1680c;
    }
}
