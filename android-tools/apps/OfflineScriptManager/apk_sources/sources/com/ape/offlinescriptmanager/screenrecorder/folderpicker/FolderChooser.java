package com.ape.offlinescriptmanager.screenrecorder.folderpicker;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Environment;
import android.os.Parcelable;
import android.preference.DialogPreference;
import android.preference.PreferenceManager;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.SpinnerAdapter;
import android.widget.TextView;
import android.widget.Toast;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.ape.offlinescriptmanager.screenrecorder.folderpicker.a;
import com.ape.offlinescriptmanager.screenrecorder.folderpicker.c;
import java.io.File;
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class FolderChooser extends DialogPreference implements View.OnClickListener, a.c, AdapterView.OnItemSelectedListener {
    private static com.ape.offlinescriptmanager.screenrecorder.folderpicker.b m;

    /* renamed from: b  reason: collision with root package name */
    private RecyclerView f2043b;

    /* renamed from: c  reason: collision with root package name */
    private TextView f2044c;

    /* renamed from: d  reason: collision with root package name */
    private TextView f2045d;
    private File e;
    private ArrayList<File> f;
    private AlertDialog g;
    private com.ape.offlinescriptmanager.screenrecorder.folderpicker.a h;
    private Spinner i;
    private List<com.ape.offlinescriptmanager.screenrecorder.folderpicker.c> j;
    private boolean k;
    private SharedPreferences l;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements TextWatcher {
        a() {
        }

        @Override // android.text.TextWatcher
        public void afterTextChanged(Editable editable) {
            if (FolderChooser.this.g != null) {
                FolderChooser.this.g.getButton(-1).setEnabled(!editable.toString().trim().isEmpty());
            }
        }

        @Override // android.text.TextWatcher
        public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        }

        @Override // android.text.TextWatcher
        public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements DialogInterface.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ EditText f2047b;

        b(EditText editText) {
            this.f2047b = editText;
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            dialogInterface.dismiss();
            String trim = this.f2047b.getText().toString().trim();
            if (trim.isEmpty()) {
                return;
            }
            FolderChooser.this.g(trim);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements DialogInterface.OnClickListener {
        c(FolderChooser folderChooser) {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            dialogInterface.dismiss();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements DialogInterface.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ CheckBox f2049b;

        d(CheckBox checkBox) {
            this.f2049b = checkBox;
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            if (this.f2049b.isChecked()) {
                FolderChooser.this.l.edit().putBoolean("ext_dir_warn_donot_show_again", true).apply();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class e implements FileFilter {
        private e(FolderChooser folderChooser) {
        }

        /* synthetic */ e(FolderChooser folderChooser, a aVar) {
            this(folderChooser);
        }

        @Override // java.io.FileFilter
        public boolean accept(File file) {
            return file.isDirectory() && !file.isHidden();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class f implements Comparator<File> {
        private f(FolderChooser folderChooser) {
        }

        /* synthetic */ f(FolderChooser folderChooser, a aVar) {
            this(folderChooser);
        }

        @Override // java.util.Comparator
        /* renamed from: a */
        public int compare(File file, File file2) {
            return file.getName().toLowerCase().compareTo(file2.getName().toLowerCase());
        }
    }

    public FolderChooser(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.j = new ArrayList();
        this.k = false;
        Log.d("SCREENRECORDER", "Constructor called");
        l();
    }

    private void e(File file) {
        this.e = file;
        Log.d("SCREENRECORDER", "Changed dir is: " + file.getPath());
        h();
        if (!m()) {
            com.ape.offlinescriptmanager.screenrecorder.folderpicker.a aVar = new com.ape.offlinescriptmanager.screenrecorder.folderpicker.a(getContext(), this, this.f);
            this.h = aVar;
            this.f2043b.s1(aVar, true);
        }
        this.f2044c.setText(this.e.getPath());
    }

    private void f(File file) {
        String i = i(this.j.get(1).a());
        if (file.getPath().contains(i) && file.canWrite()) {
            e(file);
        } else if (!file.getPath().contains(i) || file.canWrite()) {
        } else {
            Toast.makeText(getContext(), (int) R.string.external_storage_dir_not_writable, 0).show();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean g(String str) {
        File file = this.e;
        if (file == null) {
            Toast.makeText(getContext(), "No directory selected", 0).show();
            return false;
        } else if (!file.canWrite()) {
            Toast.makeText(getContext(), "No permission to write to directory", 0).show();
            return false;
        } else {
            File file2 = str.contains(Environment.getExternalStorageDirectory().getPath()) ? new File(str) : new File(this.e, str);
            if (file2.exists()) {
                Toast.makeText(getContext(), "Directory already exists", 0).show();
                e(new File(this.e, str));
                return false;
            } else if (file2.mkdir()) {
                e(new File(this.e, str));
                return true;
            } else {
                Toast.makeText(getContext(), "Error creating directory", 0).show();
                Log.d("SCREENRECORDER", file2.getPath());
                return false;
            }
        }
    }

    private void h() {
        ArrayList<File> arrayList = new ArrayList<>(Arrays.asList(this.e.listFiles(new e(this, null))));
        this.f = arrayList;
        Collections.sort(arrayList, new f(this, null));
        Log.d("SCREENRECORDER", "Directory size " + this.f.size());
    }

    private String i(String str) {
        int indexOf = str.indexOf("Android");
        Log.d("SCREENRECORDER", "Short code is: " + str.substring(0, indexOf));
        String substring = str.substring(0, indexOf + (-1));
        Log.d("SCREENRECORDER", "External Base Dir " + substring);
        return substring;
    }

    private void j() {
        this.f2043b.setHasFixedSize(true);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getContext(), 1, false);
        this.f2043b.setLayoutManager(linearLayoutManager);
        this.f2043b.i(new androidx.recyclerview.widget.d(getContext(), linearLayoutManager.j2()));
        if (!m()) {
            com.ape.offlinescriptmanager.screenrecorder.folderpicker.a aVar = new com.ape.offlinescriptmanager.screenrecorder.folderpicker.a(getContext(), this, this.f);
            this.h = aVar;
            this.f2043b.setAdapter(aVar);
        }
        this.f2044c.setText(this.e.getPath());
    }

    private void k(View view) {
        this.f2044c = (TextView) view.findViewById(R.id.tv_selected_dir);
        this.f2043b = (RecyclerView) view.findViewById(R.id.rv);
        this.f2045d = (TextView) view.findViewById(R.id.tv_empty);
        this.i = (Spinner) view.findViewById(R.id.storageSpinner);
        ((ImageButton) view.findViewById(R.id.nav_up)).setOnClickListener(this);
        ((ImageButton) view.findViewById(R.id.create_dir)).setOnClickListener(this);
        ArrayList arrayList = new ArrayList();
        for (com.ape.offlinescriptmanager.screenrecorder.folderpicker.c cVar : this.j) {
            arrayList.add(cVar.b() == c.a.Internal ? "Internal Storage" : "Removable Storage");
        }
        ArrayAdapter arrayAdapter = new ArrayAdapter(getContext(), 17367048, arrayList);
        arrayAdapter.setDropDownViewResource(17367049);
        this.i.setAdapter((SpinnerAdapter) arrayAdapter);
        this.i.setOnItemSelectedListener(this);
    }

    private void l() {
        setPersistent(true);
        setDialogTitle((CharSequence) null);
        setDialogLayoutResource(R.layout.director_chooser);
        setPositiveButtonText(17039370);
        setNegativeButtonText(17039360);
        File file = new File(com.ape.offlinescriptmanager.screenrecorder.a.f2012a);
        this.e = file;
        setSummary(getPersistedString(file.getPath()));
        Log.d("SCREENRECORDER", "Persisted String is: " + getPersistedString(this.e.getPath()));
        File[] f2 = androidx.core.content.a.f(getContext().getApplicationContext(), null);
        this.j.add(new com.ape.offlinescriptmanager.screenrecorder.folderpicker.c(Environment.getExternalStorageDirectory().getPath(), c.a.Internal));
        this.l = PreferenceManager.getDefaultSharedPreferences(getContext());
        if (f2.length > 1) {
            this.j.add(new com.ape.offlinescriptmanager.screenrecorder.folderpicker.c(f2[1].getPath(), c.a.External));
        }
    }

    private boolean m() {
        if (this.f.isEmpty()) {
            this.f2043b.setVisibility(8);
            this.f2045d.setVisibility(0);
            return true;
        }
        this.f2043b.setVisibility(0);
        this.f2045d.setVisibility(8);
        return false;
    }

    private void n(Bundle bundle) {
        View inflate = ((LayoutInflater) getContext().getSystemService("layout_inflater")).inflate(R.layout.directory_chooser_edit_text, (ViewGroup) null);
        EditText editText = (EditText) inflate.findViewById(R.id.et_new_folder);
        editText.addTextChangedListener(new a());
        AlertDialog create = new AlertDialog.Builder(getContext()).setTitle(R.string.alert_title_create_folder).setMessage(R.string.alert_message_create_folder).setView(inflate).setNegativeButton(17039360, new c(this)).setPositiveButton(17039370, new b(editText)).create();
        this.g = create;
        if (bundle != null) {
            create.onRestoreInstanceState(bundle);
        }
        this.g.show();
        this.g.getButton(-1).setEnabled(!editText.getText().toString().trim().isEmpty());
    }

    private void q() {
        View inflate = View.inflate(getContext(), R.layout.alert_checkbox, null);
        new AlertDialog.Builder(getContext()).setTitle(R.string.alert_ext_dir_warning_title).setMessage(R.string.alert_ext_dir_warning_message).setView(inflate).setNeutralButton(17039370, new d((CheckBox) inflate.findViewById(R.id.donot_warn_cb))).create().show();
    }

    @Override // com.ape.offlinescriptmanager.screenrecorder.folderpicker.a.c
    public void a(File file) {
        e(file);
    }

    public void o(String str) {
        String str2;
        File file = new File(str);
        if (file.exists() && file.isDirectory()) {
            this.e = file;
            str2 = "Directory set";
        } else {
            g(file.getPath());
            str2 = "Directory created";
        }
        Log.d("SCREENRECORDER", str2);
    }

    @Override // android.preference.DialogPreference
    protected void onBindDialogView(View view) {
        super.onBindDialogView(view);
        h();
        k(view);
        j();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id == R.id.create_dir) {
            n(null);
        } else if (id != R.id.nav_up) {
        } else {
            File file = new File(this.e.getParent());
            Log.d("SCREENRECORDER", file.getPath());
            if (this.k) {
                f(file);
            } else if (file.getPath().contains(this.j.get(0).a())) {
                e(file);
            }
        }
    }

    @Override // android.preference.DialogPreference
    protected void onDialogClosed(boolean z) {
        super.onDialogClosed(z);
        if (z) {
            Log.d("SCREENRECORDER", "Directory choosed! " + this.e.getPath());
            if (!this.e.canWrite()) {
                Toast.makeText(getContext(), "Cannot write to selected directory. Path will not be saved.", 0).show();
                return;
            }
            persistString(this.e.getPath());
            m.b();
            setSummary(this.e.getPath());
        }
    }

    @Override // android.widget.AdapterView.OnItemSelectedListener
    public void onItemSelected(AdapterView<?> adapterView, View view, int i, long j) {
        Log.d("SCREENRECORDER", "Selected storage is: " + this.j.get(i));
        boolean z = this.j.get(i).b() == c.a.External;
        this.k = z;
        if (z && !this.l.getBoolean("ext_dir_warn_donot_show_again", false)) {
            q();
        }
        e(new File(this.j.get(i).a()));
    }

    @Override // android.widget.AdapterView.OnItemSelectedListener
    public void onNothingSelected(AdapterView<?> adapterView) {
    }

    @Override // android.preference.DialogPreference, android.preference.Preference
    protected void onRestoreInstanceState(Parcelable parcelable) {
        if (parcelable == null || !parcelable.getClass().equals(SavedStateHandler.class)) {
            super.onRestoreInstanceState(parcelable);
            return;
        }
        SavedStateHandler savedStateHandler = (SavedStateHandler) parcelable;
        super.onRestoreInstanceState(savedStateHandler.getSuperState());
        o(this.e.getPath());
        Bundle bundle = savedStateHandler.f2052c;
        if (bundle != null) {
            n(bundle);
        }
    }

    @Override // android.preference.DialogPreference, android.preference.Preference
    protected Parcelable onSaveInstanceState() {
        Parcelable onSaveInstanceState = super.onSaveInstanceState();
        if (this.e == null) {
            return onSaveInstanceState;
        }
        AlertDialog alertDialog = this.g;
        return new SavedStateHandler(onSaveInstanceState, this.e.getPath(), alertDialog == null ? null : alertDialog.onSaveInstanceState());
    }

    public void p(com.ape.offlinescriptmanager.screenrecorder.folderpicker.b bVar) {
        m = bVar;
    }
}
