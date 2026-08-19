package life.knowledge4.videotrimmer.view;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.util.AttributeSet;
import android.util.LongSparseArray;
import android.view.View;
import life.knowledge4.videotrimmer.h.a;
import life.knowledge4.videotrimmer.h.c;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class TimeLineView extends View {

    /* renamed from: b  reason: collision with root package name */
    private Uri f2755b;

    /* renamed from: c  reason: collision with root package name */
    private int f2756c;

    /* renamed from: d  reason: collision with root package name */
    private LongSparseArray<Bitmap> f2757d;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends a.AbstractRunnableC0119a {
        final /* synthetic */ int i;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        a(String str, long j, String str2, int i) {
            super(str, j, str2);
            this.i = i;
        }

        @Override // life.knowledge4.videotrimmer.h.a.AbstractRunnableC0119a
        public void h() {
            Bitmap createScaledBitmap;
            try {
                LongSparseArray longSparseArray = new LongSparseArray();
                MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();
                mediaMetadataRetriever.setDataSource(TimeLineView.this.getContext(), TimeLineView.this.f2755b);
                int i = TimeLineView.this.f2756c;
                int i2 = TimeLineView.this.f2756c;
                int ceil = (int) Math.ceil(this.i / i);
                long parseInt = (Integer.parseInt(mediaMetadataRetriever.extractMetadata(9)) * 1000) / ceil;
                for (int i3 = 0; i3 < ceil; i3++) {
                    long j = i3;
                    try {
                        createScaledBitmap = Bitmap.createScaledBitmap(mediaMetadataRetriever.getFrameAtTime(j * parseInt, 2), i, i2, false);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    longSparseArray.put(j, createScaledBitmap);
                }
                mediaMetadataRetriever.release();
                TimeLineView.this.g(longSparseArray);
            } catch (Throwable th) {
                Thread.getDefaultUncaughtExceptionHandler().uncaughtException(Thread.currentThread(), th);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ LongSparseArray f2758b;

        b(LongSparseArray longSparseArray) {
            this.f2758b = longSparseArray;
        }

        @Override // java.lang.Runnable
        public void run() {
            TimeLineView.this.f2757d = this.f2758b;
            TimeLineView.this.invalidate();
        }
    }

    public TimeLineView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public TimeLineView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f2757d = null;
        f();
    }

    private void e(int i) {
        life.knowledge4.videotrimmer.h.a.e(new a(BuildConfig.FLAVOR, 0L, BuildConfig.FLAVOR, i));
    }

    private void f() {
        this.f2756c = getContext().getResources().getDimensionPixelOffset(life.knowledge4.videotrimmer.b.frames_video_height);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g(LongSparseArray<Bitmap> longSparseArray) {
        c.d(BuildConfig.FLAVOR, new b(longSparseArray), 0L);
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (this.f2757d != null) {
            canvas.save();
            int i = 0;
            for (int i2 = 0; i2 < this.f2757d.size(); i2++) {
                Bitmap bitmap = this.f2757d.get(i2);
                if (bitmap != null) {
                    canvas.drawBitmap(bitmap, i, 0.0f, (Paint) null);
                    i += bitmap.getWidth();
                }
            }
        }
    }

    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        setMeasuredDimension(View.resolveSizeAndState(getPaddingLeft() + getPaddingRight() + getSuggestedMinimumWidth(), i, 1), View.resolveSizeAndState(getPaddingBottom() + getPaddingTop() + this.f2756c, i2, 1));
    }

    @Override // android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        if (i != i3) {
            e(i);
        }
    }

    public void setVideo(Uri uri) {
        this.f2755b = uri;
    }
}
