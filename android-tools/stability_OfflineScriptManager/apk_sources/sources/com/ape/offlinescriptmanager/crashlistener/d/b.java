package com.ape.offlinescriptmanager.crashlistener.d;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.StrictMode;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;
import androidx.core.content.FileProvider;
import androidx.recyclerview.widget.RecyclerView;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b extends RecyclerView.g<RecyclerView.c0> {

    /* renamed from: c  reason: collision with root package name */
    private ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> f1963c;

    /* renamed from: d  reason: collision with root package name */
    private Context f1964d;

    /* loaded from: classes.dex */
    class a implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ c f1965b;

        /* renamed from: com.ape.offlinescriptmanager.crashlistener.d.b$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        class C0074a implements PopupMenu.OnMenuItemClickListener {
            C0074a() {
            }

            @Override // android.widget.PopupMenu.OnMenuItemClickListener
            public boolean onMenuItemClick(MenuItem menuItem) {
                int itemId = menuItem.getItemId();
                if (itemId == R.id.delete) {
                    a aVar = a.this;
                    b.this.A(aVar.f1965b.j());
                    return true;
                } else if (itemId != R.id.share) {
                    return true;
                } else {
                    a aVar2 = a.this;
                    b.this.C(aVar2.f1965b.j());
                    return true;
                }
            }
        }

        a(c cVar) {
            this.f1965b = cVar;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            PopupMenu popupMenu = new PopupMenu(b.this.f1964d, view);
            popupMenu.setOnMenuItemClickListener(new C0074a());
            popupMenu.inflate(R.menu.popupmenu_picture);
            popupMenu.show();
        }
    }

    /* renamed from: com.ape.offlinescriptmanager.crashlistener.d.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class View$OnClickListenerC0075b implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ c f1968b;

        View$OnClickListenerC0075b(c cVar) {
            this.f1968b = cVar;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            Uri e = FileProvider.e(b.this.f1964d.getApplicationContext(), "com.ape.offlinescriptmanager.fileprovider", new File(((com.ape.offlinescriptmanager.crashlistener.d.a) b.this.f1963c.get(this.f1968b.j())).c().getPath()));
            Intent intent = new Intent();
            intent.setFlags(268435456);
            intent.setAction("android.intent.action.VIEW").addFlags(1).setDataAndType(e, b.this.f1964d.getContentResolver().getType(e));
            b.this.f1964d.startActivity(intent);
        }
    }

    /* loaded from: classes.dex */
    private final class c extends RecyclerView.c0 {
        private TextView u;
        private ImageView v;
        private RelativeLayout w;
        private ImageButton x;

        c(b bVar, View view) {
            super(view);
            this.u = (TextView) view.findViewById(R.id.fileName);
            ImageView imageView = (ImageView) view.findViewById(R.id.thumbnail);
            this.v = imageView;
            imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
            this.w = (RelativeLayout) view.findViewById(R.id.videoCard);
            this.x = (ImageButton) view.findViewById(R.id.ic_overflow);
        }
    }

    /* loaded from: classes.dex */
    private final class d extends RecyclerView.c0 {
        private TextView u;

        d(b bVar, View view) {
            super(view);
            this.u = (TextView) view.findViewById(R.id.sectionID);
        }
    }

    public b(Context context, ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> arrayList, com.ape.offlinescriptmanager.crashlistener.a aVar) {
        this.f1963c = arrayList;
        this.f1964d = context;
        StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
        StrictMode.setVmPolicy(builder.build());
        builder.detectFileUriExposure();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void A(int i) {
        if (new File(this.f1963c.get(i).c().getPath()).delete()) {
            Toast.makeText(this.f1964d, "File deleted successfully", 0).show();
            this.f1963c.remove(i);
            j(i);
            i(i, this.f1963c.size());
        }
    }

    private String B(Date date) {
        SimpleDateFormat simpleDateFormat;
        Calendar D = D(new Date().getTime());
        Calendar D2 = D(date.getTime());
        int abs = (int) Math.abs((D2.getTimeInMillis() - D.getTimeInMillis()) / 86400000);
        int i = D.get(1) - D2.get(1);
        Log.d("ScreenRecorder", "yeardiff: " + i);
        if (i != 0) {
            simpleDateFormat = new SimpleDateFormat("EEEE, dd MMM YYYY", Locale.getDefault());
        } else if (abs == 0) {
            return "Today";
        } else {
            if (abs == 1) {
                return "Yesterday";
            }
            simpleDateFormat = new SimpleDateFormat("EEEE, dd MMM", Locale.getDefault());
        }
        return simpleDateFormat.format(date);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void C(int i) {
        Intent putExtra = new Intent().setAction("android.intent.action.SEND").setType("picture/*").putExtra("android.intent.extra.STREAM", this.f1963c.get(i).c());
        Context context = this.f1964d;
        context.startActivity(Intent.createChooser(putExtra, context.getString(R.string.share_picture_notification_title)));
    }

    private Calendar D(long j) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(j);
        calendar.set(11, 0);
        calendar.set(12, 0);
        calendar.set(13, 0);
        calendar.set(14, 0);
        return calendar;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public int c() {
        return this.f1963c.size();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public int e(int i) {
        return !v(i);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public void l(RecyclerView.c0 c0Var, int i) {
        int l = c0Var.l();
        if (l == 0) {
            ((d) c0Var).u.setText(B(this.f1963c.get(i).e()));
        } else if (l != 1) {
        } else {
            c cVar = (c) c0Var;
            cVar.u.setText(this.f1963c.get(i).d());
            if (this.f1963c.get(i).f() != null) {
                cVar.v.setImageBitmap(this.f1963c.get(i).f());
            } else {
                cVar.v.setImageResource(0);
            }
            cVar.x.setOnClickListener(new a(cVar));
            cVar.w.setOnClickListener(new View$OnClickListenerC0075b(cVar));
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public RecyclerView.c0 n(ViewGroup viewGroup, int i) {
        return i != 0 ? i != 1 ? new c(this, LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.content_video, viewGroup, false)) : new c(this, LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.content_video, viewGroup, false)) : new d(this, LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.content_video_section, viewGroup, false));
    }

    public boolean v(int i) {
        return this.f1963c.get(i).a();
    }
}
