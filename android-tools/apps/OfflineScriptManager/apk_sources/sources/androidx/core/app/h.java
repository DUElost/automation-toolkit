package androidx.core.app;

import android.app.Notification;
import android.app.RemoteInput;
import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.SparseArray;
import android.widget.RemoteViews;
import androidx.core.app.g;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
/* loaded from: classes.dex */
class h implements f {

    /* renamed from: a  reason: collision with root package name */
    private final Notification.Builder f845a;

    /* renamed from: b  reason: collision with root package name */
    private final g.b f846b;

    /* renamed from: c  reason: collision with root package name */
    private RemoteViews f847c;

    /* renamed from: d  reason: collision with root package name */
    private RemoteViews f848d;
    private final List<Bundle> e = new ArrayList();
    private final Bundle f = new Bundle();
    private int g;
    private RemoteViews h;

    /* JADX INFO: Access modifiers changed from: package-private */
    public h(g.b bVar) {
        ArrayList<String> arrayList;
        Bundle bundle;
        String str;
        this.f846b = bVar;
        int i = Build.VERSION.SDK_INT;
        Context context = bVar.f841a;
        this.f845a = i >= 26 ? new Notification.Builder(context, bVar.I) : new Notification.Builder(context);
        Notification notification = bVar.N;
        this.f845a.setWhen(notification.when).setSmallIcon(notification.icon, notification.iconLevel).setContent(notification.contentView).setTicker(notification.tickerText, bVar.h).setVibrate(notification.vibrate).setLights(notification.ledARGB, notification.ledOnMS, notification.ledOffMS).setOngoing((notification.flags & 2) != 0).setOnlyAlertOnce((notification.flags & 8) != 0).setAutoCancel((notification.flags & 16) != 0).setDefaults(notification.defaults).setContentTitle(bVar.f844d).setContentText(bVar.e).setContentInfo(bVar.j).setContentIntent(bVar.f).setDeleteIntent(notification.deleteIntent).setFullScreenIntent(bVar.g, (notification.flags & 128) != 0).setLargeIcon(bVar.i).setNumber(bVar.k).setProgress(bVar.r, bVar.s, bVar.t);
        if (i < 21) {
            this.f845a.setSound(notification.sound, notification.audioStreamType);
        }
        if (i >= 16) {
            this.f845a.setSubText(bVar.p).setUsesChronometer(bVar.n).setPriority(bVar.l);
            Iterator<g.a> it = bVar.f842b.iterator();
            while (it.hasNext()) {
                a(it.next());
            }
            Bundle bundle2 = bVar.B;
            if (bundle2 != null) {
                this.f.putAll(bundle2);
            }
            if (Build.VERSION.SDK_INT < 20) {
                if (bVar.x) {
                    this.f.putBoolean("android.support.localOnly", true);
                }
                String str2 = bVar.u;
                if (str2 != null) {
                    this.f.putString("android.support.groupKey", str2);
                    if (bVar.v) {
                        bundle = this.f;
                        str = "android.support.isGroupSummary";
                    } else {
                        bundle = this.f;
                        str = "android.support.useSideChannel";
                    }
                    bundle.putBoolean(str, true);
                }
                String str3 = bVar.w;
                if (str3 != null) {
                    this.f.putString("android.support.sortKey", str3);
                }
            }
            this.f847c = bVar.F;
            this.f848d = bVar.G;
        }
        int i2 = Build.VERSION.SDK_INT;
        if (i2 >= 19) {
            this.f845a.setShowWhen(bVar.m);
            if (i2 < 21 && (arrayList = bVar.O) != null && !arrayList.isEmpty()) {
                Bundle bundle3 = this.f;
                ArrayList<String> arrayList2 = bVar.O;
                bundle3.putStringArray("android.people", (String[]) arrayList2.toArray(new String[arrayList2.size()]));
            }
        }
        if (i2 >= 20) {
            this.f845a.setLocalOnly(bVar.x).setGroup(bVar.u).setGroupSummary(bVar.v).setSortKey(bVar.w);
            this.g = bVar.M;
        }
        if (i2 >= 21) {
            this.f845a.setCategory(bVar.A).setColor(bVar.C).setVisibility(bVar.D).setPublicVersion(bVar.E).setSound(notification.sound, notification.audioAttributes);
            Iterator<String> it2 = bVar.O.iterator();
            while (it2.hasNext()) {
                this.f845a.addPerson(it2.next());
            }
            this.h = bVar.H;
            if (bVar.f843c.size() > 0) {
                Bundle bundle4 = bVar.c().getBundle("android.car.EXTENSIONS");
                bundle4 = bundle4 == null ? new Bundle() : bundle4;
                Bundle bundle5 = new Bundle();
                for (int i3 = 0; i3 < bVar.f843c.size(); i3++) {
                    bundle5.putBundle(Integer.toString(i3), i.b(bVar.f843c.get(i3)));
                }
                bundle4.putBundle("invisible_actions", bundle5);
                bVar.c().putBundle("android.car.EXTENSIONS", bundle4);
                this.f.putBundle("android.car.EXTENSIONS", bundle4);
            }
        }
        int i4 = Build.VERSION.SDK_INT;
        if (i4 >= 24) {
            this.f845a.setExtras(bVar.B).setRemoteInputHistory(bVar.q);
            RemoteViews remoteViews = bVar.F;
            if (remoteViews != null) {
                this.f845a.setCustomContentView(remoteViews);
            }
            RemoteViews remoteViews2 = bVar.G;
            if (remoteViews2 != null) {
                this.f845a.setCustomBigContentView(remoteViews2);
            }
            RemoteViews remoteViews3 = bVar.H;
            if (remoteViews3 != null) {
                this.f845a.setCustomHeadsUpContentView(remoteViews3);
            }
        }
        if (i4 >= 26) {
            this.f845a.setBadgeIconType(bVar.J).setShortcutId(bVar.K).setTimeoutAfter(bVar.L).setGroupAlertBehavior(bVar.M);
            if (bVar.z) {
                this.f845a.setColorized(bVar.y);
            }
            if (TextUtils.isEmpty(bVar.I)) {
                return;
            }
            this.f845a.setSound(null).setDefaults(0).setLights(0, 0, 0).setVibrate(null);
        }
    }

    private void a(g.a aVar) {
        int i = Build.VERSION.SDK_INT;
        if (i < 20) {
            if (i >= 16) {
                this.e.add(i.f(this.f845a, aVar));
                return;
            }
            return;
        }
        Notification.Action.Builder builder = new Notification.Action.Builder(aVar.e(), aVar.i(), aVar.a());
        if (aVar.f() != null) {
            for (RemoteInput remoteInput : j.b(aVar.f())) {
                builder.addRemoteInput(remoteInput);
            }
        }
        Bundle bundle = aVar.d() != null ? new Bundle(aVar.d()) : new Bundle();
        bundle.putBoolean("android.support.allowGeneratedReplies", aVar.b());
        int i2 = Build.VERSION.SDK_INT;
        if (i2 >= 24) {
            builder.setAllowGeneratedReplies(aVar.b());
        }
        bundle.putInt("android.support.action.semanticAction", aVar.g());
        if (i2 >= 28) {
            builder.setSemanticAction(aVar.g());
        }
        bundle.putBoolean("android.support.action.showsUserInterface", aVar.h());
        builder.addExtras(bundle);
        this.f845a.addAction(builder.build());
    }

    private void d(Notification notification) {
        notification.sound = null;
        notification.vibrate = null;
        int i = notification.defaults & (-2);
        notification.defaults = i;
        notification.defaults = i & (-3);
    }

    public Notification b() {
        Bundle a2;
        RemoteViews e;
        RemoteViews c2;
        g.c cVar = this.f846b.o;
        if (cVar != null) {
            cVar.b(this);
        }
        RemoteViews d2 = cVar != null ? cVar.d(this) : null;
        Notification c3 = c();
        if (d2 != null || (d2 = this.f846b.F) != null) {
            c3.contentView = d2;
        }
        int i = Build.VERSION.SDK_INT;
        if (i >= 16 && cVar != null && (c2 = cVar.c(this)) != null) {
            c3.bigContentView = c2;
        }
        if (i >= 21 && cVar != null && (e = this.f846b.o.e(this)) != null) {
            c3.headsUpContentView = e;
        }
        if (i >= 16 && cVar != null && (a2 = g.a(c3)) != null) {
            cVar.a(a2);
        }
        return c3;
    }

    protected Notification c() {
        int i = Build.VERSION.SDK_INT;
        if (i >= 26) {
            return this.f845a.build();
        }
        if (i >= 24) {
            Notification build = this.f845a.build();
            if (this.g != 0) {
                if (build.getGroup() != null && (build.flags & 512) != 0 && this.g == 2) {
                    d(build);
                }
                if (build.getGroup() != null && (build.flags & 512) == 0 && this.g == 1) {
                    d(build);
                }
            }
            return build;
        } else if (i >= 21) {
            this.f845a.setExtras(this.f);
            Notification build2 = this.f845a.build();
            RemoteViews remoteViews = this.f847c;
            if (remoteViews != null) {
                build2.contentView = remoteViews;
            }
            RemoteViews remoteViews2 = this.f848d;
            if (remoteViews2 != null) {
                build2.bigContentView = remoteViews2;
            }
            RemoteViews remoteViews3 = this.h;
            if (remoteViews3 != null) {
                build2.headsUpContentView = remoteViews3;
            }
            if (this.g != 0) {
                if (build2.getGroup() != null && (build2.flags & 512) != 0 && this.g == 2) {
                    d(build2);
                }
                if (build2.getGroup() != null && (build2.flags & 512) == 0 && this.g == 1) {
                    d(build2);
                }
            }
            return build2;
        } else if (i >= 20) {
            this.f845a.setExtras(this.f);
            Notification build3 = this.f845a.build();
            RemoteViews remoteViews4 = this.f847c;
            if (remoteViews4 != null) {
                build3.contentView = remoteViews4;
            }
            RemoteViews remoteViews5 = this.f848d;
            if (remoteViews5 != null) {
                build3.bigContentView = remoteViews5;
            }
            if (this.g != 0) {
                if (build3.getGroup() != null && (build3.flags & 512) != 0 && this.g == 2) {
                    d(build3);
                }
                if (build3.getGroup() != null && (build3.flags & 512) == 0 && this.g == 1) {
                    d(build3);
                }
            }
            return build3;
        } else if (i >= 19) {
            SparseArray<Bundle> a2 = i.a(this.e);
            if (a2 != null) {
                this.f.putSparseParcelableArray("android.support.actionExtras", a2);
            }
            this.f845a.setExtras(this.f);
            Notification build4 = this.f845a.build();
            RemoteViews remoteViews6 = this.f847c;
            if (remoteViews6 != null) {
                build4.contentView = remoteViews6;
            }
            RemoteViews remoteViews7 = this.f848d;
            if (remoteViews7 != null) {
                build4.bigContentView = remoteViews7;
            }
            return build4;
        } else if (i >= 16) {
            Notification build5 = this.f845a.build();
            Bundle a3 = g.a(build5);
            Bundle bundle = new Bundle(this.f);
            for (String str : this.f.keySet()) {
                if (a3.containsKey(str)) {
                    bundle.remove(str);
                }
            }
            a3.putAll(bundle);
            SparseArray<Bundle> a4 = i.a(this.e);
            if (a4 != null) {
                g.a(build5).putSparseParcelableArray("android.support.actionExtras", a4);
            }
            RemoteViews remoteViews8 = this.f847c;
            if (remoteViews8 != null) {
                build5.contentView = remoteViews8;
            }
            RemoteViews remoteViews9 = this.f848d;
            if (remoteViews9 != null) {
                build5.bigContentView = remoteViews9;
            }
            return build5;
        } else {
            return this.f845a.getNotification();
        }
    }
}
