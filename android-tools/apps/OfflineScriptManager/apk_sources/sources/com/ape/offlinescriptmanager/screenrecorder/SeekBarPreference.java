package com.ape.offlinescriptmanager.screenrecorder;

import android.content.Context;
import android.preference.DialogPreference;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.TextView;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class SeekBarPreference extends DialogPreference implements SeekBar.OnSeekBarChangeListener {

    /* renamed from: b  reason: collision with root package name */
    private SeekBar f2009b;

    /* renamed from: c  reason: collision with root package name */
    private TextView f2010c;

    /* renamed from: d  reason: collision with root package name */
    private ImageView f2011d;
    private String e;
    private int f;
    private int g;
    private int h;
    private int i;
    private ViewGroup.LayoutParams j;

    public SeekBarPreference(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.h = 0;
        setPersistent(true);
        setDialogLayoutResource(R.layout.layout_floating_control_preview);
        this.e = attributeSet.getAttributeValue("http://schemas.android.com/apk/res/android", "text");
        this.f = attributeSet.getAttributeIntValue("http://schemas.android.com/apk/res/android", "defaultValue", 100);
        this.g = attributeSet.getAttributeIntValue("http://schemas.android.com/apk/res/android", "max", 200);
    }

    private int a(int i) {
        return Math.round(i * (getContext().getResources().getDisplayMetrics().xdpi / 160.0f));
    }

    private ViewGroup.LayoutParams b(int i) {
        int a2 = a(i);
        ViewGroup.LayoutParams layoutParams = this.j;
        layoutParams.height = a2;
        layoutParams.width = a2;
        return layoutParams;
    }

    private void c() {
        this.f2009b.setOnSeekBarChangeListener(this);
        this.j = this.f2011d.getLayoutParams();
        this.f2011d.setLayoutParams(b(this.h));
        this.f2010c.setText(this.e == null ? String.valueOf(this.h) : String.valueOf(this.h).concat(this.e));
        Log.d("SCREENRECORDER", "Max: " + this.g + "     ,Progress: " + this.h);
    }

    @Override // android.preference.DialogPreference
    protected void onBindDialogView(View view) {
        super.onBindDialogView(view);
        this.h = getPersistedInt(this.f);
        Log.d("SCREENRECORDER", "size is: " + this.h);
        this.f2009b = (SeekBar) view.findViewById(R.id.seekBar);
        TextView textView = (TextView) view.findViewById(R.id.tv_size);
        this.f2010c = textView;
        this.i = textView.getTextColors().getDefaultColor();
        this.f2011d = (ImageView) view.findViewById(R.id.iv_floatingControl);
        this.f2009b.setMax(this.g);
        this.f2009b.setProgress(this.h);
        c();
    }

    @Override // android.widget.SeekBar.OnSeekBarChangeListener
    public void onProgressChanged(SeekBar seekBar, int i, boolean z) {
        TextView textView;
        int i2;
        if (i < 70) {
            textView = this.f2010c;
            i2 = -65536;
        } else {
            textView = this.f2010c;
            i2 = this.i;
        }
        textView.setTextColor(i2);
        if (i < 25) {
            this.f2009b.setProgress(25);
            return;
        }
        String valueOf = String.valueOf(i);
        TextView textView2 = this.f2010c;
        String str = this.e;
        if (str != null) {
            valueOf = valueOf.concat(str);
        }
        textView2.setText(valueOf);
        this.f2011d.setLayoutParams(b(i));
        if (shouldPersist()) {
            persistInt(i);
        }
        callChangeListener(Integer.valueOf(i));
    }

    @Override // android.preference.Preference
    protected void onSetInitialValue(boolean z, Object obj) {
        super.onSetInitialValue(z, obj);
        this.h = z ? shouldPersist() ? getPersistedInt(this.f) : 100 : ((Integer) obj).intValue();
    }

    @Override // android.widget.SeekBar.OnSeekBarChangeListener
    public void onStartTrackingTouch(SeekBar seekBar) {
    }

    @Override // android.widget.SeekBar.OnSeekBarChangeListener
    public void onStopTrackingTouch(SeekBar seekBar) {
    }
}
