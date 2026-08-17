package javax.activation;

import java.io.InputStream;
import java.io.OutputStream;
/* loaded from: classes.dex */
class DataHandlerDataSource implements DataSource {
    DataHandler dataHandler;

    public DataHandlerDataSource(DataHandler dataHandler) {
        this.dataHandler = null;
        this.dataHandler = dataHandler;
    }

    @Override // javax.activation.DataSource
    public String getContentType() {
        return this.dataHandler.getContentType();
    }

    @Override // javax.activation.DataSource
    public InputStream getInputStream() {
        return this.dataHandler.getInputStream();
    }

    @Override // javax.activation.DataSource
    public String getName() {
        return this.dataHandler.getName();
    }

    @Override // javax.activation.DataSource
    public OutputStream getOutputStream() {
        return this.dataHandler.getOutputStream();
    }
}
