package life.knowledge4.videotrimmer.view;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import java.util.List;
import java.util.Vector;
import life.knowledge4.videotrimmer.c;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private int f2760a;

    /* renamed from: b  reason: collision with root package name */
    private float f2761b = 0.0f;

    /* renamed from: c  reason: collision with root package name */
    private float f2762c = 0.0f;

    /* renamed from: d  reason: collision with root package name */
    private Bitmap f2763d;
    private int e;
    private int f;
    private float g;

    private a() {
    }

    private int b() {
        return this.f;
    }

    public static int c(List<a> list) {
        return list.get(0).b();
    }

    public static int i(List<a> list) {
        return list.get(0).h();
    }

    public static List<a> j(Resources resources) {
        Vector vector = new Vector();
        int i = 0;
        while (i < 2) {
            a aVar = new a();
            aVar.l(i);
            aVar.k(BitmapFactory.decodeResource(resources, i == 0 ? c.apptheme_text_select_handle_left : c.apptheme_text_select_handle_right));
            vector.add(aVar);
            i++;
        }
        return vector;
    }

    private void k(Bitmap bitmap) {
        this.f2763d = bitmap;
        this.e = bitmap.getWidth();
        this.f = bitmap.getHeight();
    }

    private void l(int i) {
        this.f2760a = i;
    }

    public Bitmap a() {
        return this.f2763d;
    }

    public int d() {
        return this.f2760a;
    }

    public float e() {
        return this.g;
    }

    public float f() {
        return this.f2762c;
    }

    public float g() {
        return this.f2761b;
    }

    public int h() {
        return this.e;
    }

    public void m(float f) {
        this.g = f;
    }

    public void n(float f) {
        this.f2762c = f;
    }

    public void o(float f) {
        this.f2761b = f;
    }
}
