package life.knowledge4.videotrimmer;

import android.content.Context;
import android.media.MediaMetadataRetriever;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.util.AttributeSet;
import android.util.Log;
import android.view.GestureDetector;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.VideoView;
import java.io.File;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Formatter;
import java.util.List;
import life.knowledge4.videotrimmer.h.a;
import life.knowledge4.videotrimmer.view.ProgressBarView;
import life.knowledge4.videotrimmer.view.RangeSeekBarView;
import life.knowledge4.videotrimmer.view.TimeLineView;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class K4LVideoTrimmer extends FrameLayout implements MediaPlayer.OnErrorListener, MediaPlayer.OnPreparedListener, MediaPlayer.OnCompletionListener, SeekBar.OnSeekBarChangeListener, life.knowledge4.videotrimmer.g.b, life.knowledge4.videotrimmer.g.a {
    private static final String z = K4LVideoTrimmer.class.getSimpleName();

    /* renamed from: b  reason: collision with root package name */
    private SeekBar f2729b;

    /* renamed from: c  reason: collision with root package name */
    private RangeSeekBarView f2730c;

    /* renamed from: d  reason: collision with root package name */
    private RelativeLayout f2731d;
    private VideoView e;
    private ImageView f;
    private TextView g;
    private TextView h;
    private TextView i;
    private TimeLineView j;
    private Uri k;
    private String l;
    private int m;
    private List<life.knowledge4.videotrimmer.g.a> n;
    private life.knowledge4.videotrimmer.g.c o;
    private int p;
    private int q;
    private int r;
    private int s;
    private long t;
    private boolean u;
    private final f v;
    private GestureDetector w;
    private final GestureDetector.SimpleOnGestureListener x;
    private final View.OnTouchListener y;

    /* loaded from: classes.dex */
    class a extends GestureDetector.SimpleOnGestureListener {
        a() {
        }

        @Override // android.view.GestureDetector.SimpleOnGestureListener, android.view.GestureDetector.OnDoubleTapListener
        public boolean onSingleTapConfirmed(MotionEvent motionEvent) {
            if (K4LVideoTrimmer.this.e.isPlaying()) {
                K4LVideoTrimmer.this.f.setVisibility(0);
                K4LVideoTrimmer.this.v.removeMessages(2);
                K4LVideoTrimmer.this.e.pause();
                return true;
            }
            K4LVideoTrimmer.this.f.setVisibility(8);
            if (K4LVideoTrimmer.this.u) {
                K4LVideoTrimmer.this.u = false;
                K4LVideoTrimmer.this.e.seekTo(K4LVideoTrimmer.this.r);
            }
            K4LVideoTrimmer.this.v.sendEmptyMessage(2);
            K4LVideoTrimmer.this.e.start();
            return true;
        }
    }

    /* loaded from: classes.dex */
    class b implements View.OnTouchListener {
        b() {
        }

        @Override // android.view.View.OnTouchListener
        public boolean onTouch(View view, MotionEvent motionEvent) {
            K4LVideoTrimmer.this.w.onTouchEvent(motionEvent);
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements View.OnClickListener {
        c() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            K4LVideoTrimmer.this.o.d();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements View.OnClickListener {
        d() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (K4LVideoTrimmer.this.r <= 0 && K4LVideoTrimmer.this.s >= K4LVideoTrimmer.this.p) {
                K4LVideoTrimmer.this.o.m(K4LVideoTrimmer.this.k);
                return;
            }
            K4LVideoTrimmer.this.f.setVisibility(0);
            K4LVideoTrimmer.this.e.pause();
            MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();
            mediaMetadataRetriever.setDataSource(K4LVideoTrimmer.this.getContext(), K4LVideoTrimmer.this.k);
            long parseLong = Long.parseLong(mediaMetadataRetriever.extractMetadata(9));
            File file = new File(K4LVideoTrimmer.this.k.getPath());
            if (K4LVideoTrimmer.this.q < 1000) {
                if (parseLong - K4LVideoTrimmer.this.s > 1000 - K4LVideoTrimmer.this.q) {
                    K4LVideoTrimmer.this.s += 1000 - K4LVideoTrimmer.this.q;
                } else if (K4LVideoTrimmer.this.r > 1000 - K4LVideoTrimmer.this.q) {
                    K4LVideoTrimmer.this.r -= 1000 - K4LVideoTrimmer.this.q;
                }
            }
            K4LVideoTrimmer k4LVideoTrimmer = K4LVideoTrimmer.this;
            k4LVideoTrimmer.A(file, k4LVideoTrimmer.l, K4LVideoTrimmer.this.r, K4LVideoTrimmer.this.s, K4LVideoTrimmer.this.o);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e extends a.AbstractRunnableC0119a {
        final /* synthetic */ File i;
        final /* synthetic */ String j;
        final /* synthetic */ int k;
        final /* synthetic */ int l;
        final /* synthetic */ life.knowledge4.videotrimmer.g.c m;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        e(K4LVideoTrimmer k4LVideoTrimmer, String str, long j, String str2, File file, String str3, int i, int i2, life.knowledge4.videotrimmer.g.c cVar) {
            super(str, j, str2);
            this.i = file;
            this.j = str3;
            this.k = i;
            this.l = i2;
            this.m = cVar;
        }

        @Override // life.knowledge4.videotrimmer.h.a.AbstractRunnableC0119a
        public void h() {
            try {
                life.knowledge4.videotrimmer.h.b.c(this.i, this.j, this.k, this.l, this.m);
            } catch (Throwable th) {
                Thread.getDefaultUncaughtExceptionHandler().uncaughtException(Thread.currentThread(), th);
            }
        }
    }

    /* loaded from: classes.dex */
    private static class f extends Handler {

        /* renamed from: a  reason: collision with root package name */
        private final WeakReference<K4LVideoTrimmer> f2736a;

        f(K4LVideoTrimmer k4LVideoTrimmer) {
            this.f2736a = new WeakReference<>(k4LVideoTrimmer);
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            K4LVideoTrimmer k4LVideoTrimmer = this.f2736a.get();
            if (k4LVideoTrimmer == null || k4LVideoTrimmer.e == null) {
                return;
            }
            k4LVideoTrimmer.C(true);
            if (k4LVideoTrimmer.e.isPlaying()) {
                sendEmptyMessageDelayed(0, 10L);
            }
        }
    }

    public K4LVideoTrimmer(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public K4LVideoTrimmer(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.p = 0;
        this.q = 0;
        this.r = 0;
        this.s = 0;
        this.u = true;
        this.v = new f(this);
        this.x = new a();
        this.y = new b();
        w(context);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void A(File file, String str, int i, int i2, life.knowledge4.videotrimmer.g.c cVar) {
        life.knowledge4.videotrimmer.h.a.e(new e(this, BuildConfig.FLAVOR, 0L, BuildConfig.FLAVOR, file, str, i, i2, cVar));
    }

    private String B(int i) {
        int i2 = i / 1000;
        int i3 = i2 % 60;
        int i4 = (i2 / 60) % 60;
        int i5 = i2 / 3600;
        Formatter formatter = new Formatter();
        return (i5 > 0 ? formatter.format("%d:%02d:%02d", Integer.valueOf(i5), Integer.valueOf(i4), Integer.valueOf(i3)) : formatter.format("%02d:%02d", Integer.valueOf(i4), Integer.valueOf(i3))).toString();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void C(boolean z2) {
        if (this.p == 0) {
            return;
        }
        int currentPosition = this.e.getCurrentPosition();
        if (!z2) {
            int i = this.p;
            this.n.get(1).c(currentPosition, i, (currentPosition * 100) / i);
            return;
        }
        for (life.knowledge4.videotrimmer.g.a aVar : this.n) {
            int i2 = this.p;
            aVar.c(currentPosition, i2, (currentPosition * 100) / i2);
        }
    }

    private void getSizeFile() {
        TextView textView;
        String format;
        if (this.t == 0) {
            long length = new File(this.k.getPath()).length();
            this.t = length;
            long j = length / 1024;
            if (j > 1000) {
                textView = this.g;
                format = String.format("%s %s", Long.valueOf(j / 1024), getContext().getString(life.knowledge4.videotrimmer.f.megabyte));
            } else {
                textView = this.g;
                format = String.format("%s %s", Long.valueOf(j), getContext().getString(life.knowledge4.videotrimmer.f.kilobyte));
            }
            textView.setText(format);
        }
    }

    private void setProgressBarPosition(int i) {
        int i2 = this.p;
        if (i2 > 0) {
            this.f2729b.setProgress((int) ((i * 1000) / i2));
        }
    }

    private void setTimeVideo(int i) {
        this.i.setText(String.format("%s %s", B(i), getContext().getString(life.knowledge4.videotrimmer.f.short_seconds)));
    }

    private void w(Context context) {
        LayoutInflater.from(context).inflate(life.knowledge4.videotrimmer.e.view_time_line, (ViewGroup) this, true);
        this.f2729b = (SeekBar) findViewById(life.knowledge4.videotrimmer.d.handlerTop);
        ProgressBarView progressBarView = (ProgressBarView) findViewById(life.knowledge4.videotrimmer.d.timeVideoView);
        this.f2730c = (RangeSeekBarView) findViewById(life.knowledge4.videotrimmer.d.timeLineBar);
        this.f2731d = (RelativeLayout) findViewById(life.knowledge4.videotrimmer.d.layout_surface_view);
        this.e = (VideoView) findViewById(life.knowledge4.videotrimmer.d.video_loader);
        this.f = (ImageView) findViewById(life.knowledge4.videotrimmer.d.icon_video_play);
        this.g = (TextView) findViewById(life.knowledge4.videotrimmer.d.textSize);
        this.h = (TextView) findViewById(life.knowledge4.videotrimmer.d.textTimeSelection);
        this.i = (TextView) findViewById(life.knowledge4.videotrimmer.d.textTime);
        this.j = (TimeLineView) findViewById(life.knowledge4.videotrimmer.d.timeLineView);
        View findViewById = findViewById(life.knowledge4.videotrimmer.d.btCancel);
        View findViewById2 = findViewById(life.knowledge4.videotrimmer.d.btSave);
        if (findViewById != null) {
            findViewById.setOnClickListener(new c());
        }
        if (findViewById2 != null) {
            findViewById2.setOnClickListener(new d());
        }
        ArrayList arrayList = new ArrayList();
        this.n = arrayList;
        arrayList.add(this);
        this.n.add(progressBarView);
        this.f2729b.setMax(1000);
        this.f2729b.setSecondaryProgress(0);
        this.f2730c.a(this);
        this.f2730c.a(progressBarView);
        int h = this.f2730c.getThumbs().get(0).h();
        RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) this.f2729b.getLayoutParams();
        int minimumWidth = h - (this.f2729b.getThumb().getMinimumWidth() / 2);
        layoutParams.setMargins(minimumWidth, 0, minimumWidth, 0);
        this.f2729b.setLayoutParams(layoutParams);
        RelativeLayout.LayoutParams layoutParams2 = (RelativeLayout.LayoutParams) this.j.getLayoutParams();
        layoutParams2.setMargins(h, 0, h, 0);
        this.j.setLayoutParams(layoutParams2);
        RelativeLayout.LayoutParams layoutParams3 = (RelativeLayout.LayoutParams) progressBarView.getLayoutParams();
        layoutParams3.setMargins(h, 0, h, 0);
        progressBarView.setLayoutParams(layoutParams3);
        this.f2729b.setOnSeekBarChangeListener(this);
        this.e.setOnPreparedListener(this);
        this.e.setOnCompletionListener(this);
        this.e.setOnErrorListener(this);
        this.w = new GestureDetector(getContext(), this.x);
        this.e.setOnTouchListener(this.y);
        x();
    }

    private void x() {
        File externalStorageDirectory = Environment.getExternalStorageDirectory();
        this.l = externalStorageDirectory.getPath() + File.separator;
        String str = z;
        Log.d(str, "Setting default path " + this.l);
    }

    private void y() {
        int i = this.p;
        int i2 = this.m;
        if (i >= i2) {
            int i3 = (i / 2) - (i2 / 2);
            this.r = i3;
            this.s = (i / 2) + (i2 / 2);
            this.f2730c.r(0, (i3 * 100) / i);
            this.f2730c.r(1, (this.s * 100) / this.p);
        } else {
            this.r = 0;
            this.s = i;
        }
        setProgressBarPosition(this.r);
        this.e.seekTo(this.r);
        this.q = this.p;
        this.f2730c.j();
    }

    private void z() {
        String string = getContext().getString(life.knowledge4.videotrimmer.f.short_seconds);
        this.h.setText(String.format("%s %s - %s %s", B(this.r), string, B(this.s), string));
    }

    @Override // life.knowledge4.videotrimmer.g.b
    public void a(RangeSeekBarView rangeSeekBarView, int i, float f2) {
        if (i == 0) {
            int i2 = (int) ((this.p * f2) / 100.0f);
            this.r = i2;
            this.e.seekTo(i2);
        } else if (i == 1) {
            this.s = (int) ((this.p * f2) / 100.0f);
        }
        setProgressBarPosition(this.r);
        z();
        this.q = this.s - this.r;
    }

    @Override // life.knowledge4.videotrimmer.g.b
    public void b(RangeSeekBarView rangeSeekBarView, int i, float f2) {
    }

    @Override // life.knowledge4.videotrimmer.g.a
    public void c(int i, int i2, float f2) {
        if (this.e == null) {
            return;
        }
        if (i < this.s) {
            if (this.f2729b != null) {
                setProgressBarPosition(i);
            }
            setTimeVideo(i);
            return;
        }
        this.v.removeMessages(2);
        this.e.pause();
        this.f.setVisibility(0);
        this.u = true;
    }

    @Override // life.knowledge4.videotrimmer.g.b
    public void d(RangeSeekBarView rangeSeekBarView, int i, float f2) {
        this.v.removeMessages(2);
        this.e.pause();
        this.f.setVisibility(0);
    }

    @Override // life.knowledge4.videotrimmer.g.b
    public void e(RangeSeekBarView rangeSeekBarView, int i, float f2) {
    }

    @Override // android.media.MediaPlayer.OnCompletionListener
    public void onCompletion(MediaPlayer mediaPlayer) {
        this.e.seekTo(0);
    }

    @Override // android.media.MediaPlayer.OnErrorListener
    public boolean onError(MediaPlayer mediaPlayer, int i, int i2) {
        return false;
    }

    @Override // android.media.MediaPlayer.OnPreparedListener
    public void onPrepared(MediaPlayer mediaPlayer) {
        float videoWidth = mediaPlayer.getVideoWidth() / mediaPlayer.getVideoHeight();
        int width = this.f2731d.getWidth();
        int height = this.f2731d.getHeight();
        float f2 = width;
        float f3 = height;
        ViewGroup.LayoutParams layoutParams = this.e.getLayoutParams();
        if (videoWidth > f2 / f3) {
            layoutParams.width = width;
            layoutParams.height = (int) (f2 / videoWidth);
        } else {
            layoutParams.width = (int) (videoWidth * f3);
            layoutParams.height = height;
        }
        this.e.setLayoutParams(layoutParams);
        this.f.setVisibility(0);
        this.p = this.e.getDuration();
        y();
        z();
        setTimeVideo(0);
    }

    @Override // android.widget.SeekBar.OnSeekBarChangeListener
    public void onProgressChanged(SeekBar seekBar, int i, boolean z2) {
        int i2 = (int) ((this.p * i) / 1000);
        if (z2) {
            int i3 = this.r;
            if (i2 < i3) {
                setProgressBarPosition(i3);
                i2 = this.r;
            } else {
                int i4 = this.s;
                if (i2 > i4) {
                    setProgressBarPosition(i4);
                    i2 = this.s;
                }
            }
            setTimeVideo(i2);
        }
    }

    @Override // android.widget.SeekBar.OnSeekBarChangeListener
    public void onStartTrackingTouch(SeekBar seekBar) {
        this.v.removeMessages(2);
        this.e.pause();
        this.f.setVisibility(0);
        C(false);
    }

    @Override // android.widget.SeekBar.OnSeekBarChangeListener
    public void onStopTrackingTouch(SeekBar seekBar) {
        this.v.removeMessages(2);
        this.e.pause();
        this.f.setVisibility(0);
        int progress = (int) ((this.p * seekBar.getProgress()) / 1000);
        this.e.seekTo(progress);
        setTimeVideo(progress);
        C(false);
    }

    public void setDestinationPath(String str) {
        this.l = str;
        String str2 = z;
        Log.d(str2, "Setting custom path " + this.l);
    }

    public void setMaxDuration(int i) {
        this.m = i * 1000;
    }

    public void setOnTrimVideoListener(life.knowledge4.videotrimmer.g.c cVar) {
        this.o = cVar;
    }

    public void setVideoURI(Uri uri) {
        this.k = uri;
        getSizeFile();
        this.e.setVideoURI(this.k);
        this.e.requestFocus();
        this.j.setVideo(this.k);
    }
}
