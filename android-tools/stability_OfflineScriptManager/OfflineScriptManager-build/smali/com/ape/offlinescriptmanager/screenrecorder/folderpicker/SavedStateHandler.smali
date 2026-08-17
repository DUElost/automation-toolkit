.class public Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;
.super Landroid/preference/Preference$BaseSavedState;
.source ""


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public final b:Ljava/lang/String;

.field public final c:Landroid/os/Bundle;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler$a;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler$a;-><init>()V

    sput-object v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0, p1}, Landroid/preference/Preference$BaseSavedState;-><init>(Landroid/os/Parcel;)V

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;->b:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readBundle()Landroid/os/Bundle;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;->c:Landroid/os/Bundle;

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcelable;Ljava/lang/String;Landroid/os/Bundle;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/preference/Preference$BaseSavedState;-><init>(Landroid/os/Parcelable;)V

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;->b:Ljava/lang/String;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;->c:Landroid/os/Bundle;

    return-void
.end method


# virtual methods
.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0

    invoke-super {p0, p1, p2}, Landroid/preference/Preference$BaseSavedState;->writeToParcel(Landroid/os/Parcel;I)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;->b:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/SavedStateHandler;->c:Landroid/os/Bundle;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeBundle(Landroid/os/Bundle;)V

    return-void
.end method
