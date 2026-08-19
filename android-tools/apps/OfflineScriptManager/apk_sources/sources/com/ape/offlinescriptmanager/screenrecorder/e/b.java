package com.ape.offlinescriptmanager.screenrecorder.e;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
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
import com.ape.offlinescriptmanager.screenrecorder.EditVideoActivity;
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
    private com.ape.offlinescriptmanager.screenrecorder.d f2035c;

    /* renamed from: d  reason: collision with root package name */
    private ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> f2036d;
    private Context e;

    /* loaded from: classes.dex */
    class a implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ c f2037b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ int f2038c;

        /* renamed from: com.ape.offlinescriptmanager.screenrecorder.e.b$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        class C0078a implements PopupMenu.OnMenuItemClickListener {
            C0078a() {
            }

            @Override // android.widget.PopupMenu.OnMenuItemClickListener
            public boolean onMenuItemClick(MenuItem menuItem) {
                int itemId = menuItem.getItemId();
                if (itemId == R.id.delete) {
                    a aVar = a.this;
                    b.this.A(aVar.f2037b.j());
                    return true;
                } else if (itemId != R.id.edit) {
                    if (itemId != R.id.share) {
                        return true;
                    }
                    a aVar2 = a.this;
                    b.this.D(aVar2.f2037b.j());
                    return true;
                } else {
                    Context context = b.this.e;
                    Toast.makeText(context, "Edit video for " + a.this.f2037b.j(), 0).show();
                    Intent intent = new Intent(b.this.e, EditVideoActivity.class);
                    intent.putExtra("edit_video", ((com.ape.offlinescriptmanager.screenrecorder.e.a) b.this.f2036d.get(a.this.f2038c)).b().toString());
                    b.this.f2035c.startActivityForResult(intent, 1004);
                    return true;
                }
            }
        }

        a(c cVar, int i) {
            this.f2037b = cVar;
            this.f2038c = i;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            PopupMenu popupMenu = new PopupMenu(b.this.e, view);
            popupMenu.setOnMenuItemClickListener(new C0078a());
            popupMenu.inflate(R.menu.popupmenu);
            popupMenu.show();
        }
    }

    /* renamed from: com.ape.offlinescriptmanager.screenrecorder.e.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class View$OnClickListenerC0079b implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ c f2041b;

        View$OnClickListenerC0079b(c cVar) {
            this.f2041b = cVar;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            Log.d("Videos List", "video position clicked: " + this.f2041b.j());
            Context context = b.this.e;
            Uri e = FileProvider.e(context, b.this.e.getPackageName() + ".fileprovider", new File(((com.ape.offlinescriptmanager.screenrecorder.e.a) b.this.f2036d.get(this.f2041b.j())).b().getPath()));
            Intent intent = new Intent();
            intent.setAction("android.intent.action.VIEW").addFlags(1).setDataAndType(e, b.this.e.getContentResolver().getType(e));
            b.this.e.startActivity(intent);
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

    public b(Context context, ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> arrayList, com.ape.offlinescriptmanager.screenrecorder.d dVar) {
        this.f2036d = arrayList;
        this.e = context;
        this.f2035c = dVar;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void A(int i) {
        Log.d("Videos List", "delete position clicked: " + i);
        if (new File(this.f2036d.get(i).b().getPath()).delete()) {
            Toast.makeText(this.e, "File deleted successfully", 0).show();
            this.f2036d.remove(i);
            j(i);
            i(i, this.f2036d.size());
        }
    }

    private String B(Date date) {
        SimpleDateFormat simpleDateFormat;
        Calendar E = E(new Date().getTime());
        Calendar E2 = E(date.getTime());
        int abs = (int) Math.abs((E2.getTimeInMillis() - E.getTimeInMillis()) / 86400000);
        int i = E.get(1) - E2.get(1);
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
    public void D(int i) {
        File file = new File(this.f2036d.get(i).b().getPath());
        Log.d("Videos List", "share position clicked: " + i);
        Intent intent = new Intent("android.intent.action.SEND");
        intent.setType("video/*");
        Context context = this.e;
        Uri e = FileProvider.e(context, this.e.getApplicationContext().getPackageName() + ".fileprovider", file);
        Context context2 = this.e;
        context2.grantUriPermission(context2.getPackageName(), e, 2);
        intent.putExtra("android.intent.extra.STREAM", e);
        Context context3 = this.e;
        context3.startActivity(Intent.createChooser(intent, context3.getString(R.string.share_intent_notification_title)));
    }

    private Calendar E(long j) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(j);
        calendar.set(11, 0);
        calendar.set(12, 0);
        calendar.set(13, 0);
        calendar.set(14, 0);
        return calendar;
    }

    public boolean C(int i) {
        return this.f2036d.get(i).f();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public int c() {
        return this.f2036d.size();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public int e(int i) {
        return !C(i);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public void l(RecyclerView.c0 c0Var, int i) {
        int l = c0Var.l();
        if (l == 0) {
            ((d) c0Var).u.setText(B(this.f2036d.get(i).d()));
        } else if (l != 1) {
        } else {
            c cVar = (c) c0Var;
            cVar.u.setText(this.f2036d.get(i).c());
            if (this.f2036d.get(i).e() != null) {
                cVar.v.setImageBitmap(this.f2036d.get(i).e());
            } else {
                cVar.v.setImageResource(0);
                Log.d("SCREENRECORDER", "thumbnail error");
            }
            cVar.x.setOnClickListener(new a(cVar, i));
            cVar.w.setOnClickListener(new View$OnClickListenerC0079b(cVar));
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public RecyclerView.c0 n(ViewGroup viewGroup, int i) {
        return i != 0 ? i != 1 ? new c(this, LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.content_video, viewGroup, false)) : new c(this, LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.content_video, viewGroup, false)) : new d(this, LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.content_video_section, viewGroup, false));
    }
}
