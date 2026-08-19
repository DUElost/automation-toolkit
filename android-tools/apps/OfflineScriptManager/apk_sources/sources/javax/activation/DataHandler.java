package javax.activation;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PipedInputStream;
import java.io.PipedOutputStream;
import java.net.URL;
import myjava.awt.datatransfer.DataFlavor;
import myjava.awt.datatransfer.Transferable;
/* loaded from: classes.dex */
public class DataHandler implements Transferable {
    private static final DataFlavor[] emptyFlavors = new DataFlavor[0];
    private static DataContentHandlerFactory factory;
    private CommandMap currentCommandMap;
    private DataContentHandler dataContentHandler;
    private DataSource dataSource;
    private DataContentHandler factoryDCH;
    private DataSource objDataSource;
    private Object object;
    private String objectMimeType;
    private DataContentHandlerFactory oldFactory;
    private String shortType;
    private DataFlavor[] transferFlavors;

    public DataHandler(Object obj, String str) {
        this.dataSource = null;
        this.objDataSource = null;
        this.object = null;
        this.objectMimeType = null;
        this.currentCommandMap = null;
        this.transferFlavors = emptyFlavors;
        this.dataContentHandler = null;
        this.factoryDCH = null;
        this.oldFactory = null;
        this.shortType = null;
        this.object = obj;
        this.objectMimeType = str;
        this.oldFactory = factory;
    }

    public DataHandler(URL url) {
        this.dataSource = null;
        this.objDataSource = null;
        this.object = null;
        this.objectMimeType = null;
        this.currentCommandMap = null;
        this.transferFlavors = emptyFlavors;
        this.dataContentHandler = null;
        this.factoryDCH = null;
        this.oldFactory = null;
        this.shortType = null;
        this.dataSource = new URLDataSource(url);
        this.oldFactory = factory;
    }

    public DataHandler(DataSource dataSource) {
        this.dataSource = null;
        this.objDataSource = null;
        this.object = null;
        this.objectMimeType = null;
        this.currentCommandMap = null;
        this.transferFlavors = emptyFlavors;
        this.dataContentHandler = null;
        this.factoryDCH = null;
        this.oldFactory = null;
        this.shortType = null;
        this.dataSource = dataSource;
        this.oldFactory = factory;
    }

    private synchronized String getBaseType() {
        if (this.shortType == null) {
            String contentType = getContentType();
            try {
                this.shortType = new MimeType(contentType).getBaseType();
            } catch (MimeTypeParseException unused) {
                this.shortType = contentType;
            }
        }
        return this.shortType;
    }

    private synchronized CommandMap getCommandMap() {
        CommandMap commandMap = this.currentCommandMap;
        if (commandMap != null) {
            return commandMap;
        }
        return CommandMap.getDefaultCommandMap();
    }

    private synchronized DataContentHandler getDataContentHandler() {
        DataContentHandlerFactory dataContentHandlerFactory;
        DataContentHandlerFactory dataContentHandlerFactory2 = factory;
        if (dataContentHandlerFactory2 != this.oldFactory) {
            this.oldFactory = dataContentHandlerFactory2;
            this.factoryDCH = null;
            this.dataContentHandler = null;
            this.transferFlavors = emptyFlavors;
        }
        DataContentHandler dataContentHandler = this.dataContentHandler;
        if (dataContentHandler != null) {
            return dataContentHandler;
        }
        String baseType = getBaseType();
        if (this.factoryDCH == null && (dataContentHandlerFactory = factory) != null) {
            this.factoryDCH = dataContentHandlerFactory.createDataContentHandler(baseType);
        }
        DataContentHandler dataContentHandler2 = this.factoryDCH;
        if (dataContentHandler2 != null) {
            this.dataContentHandler = dataContentHandler2;
        }
        if (this.dataContentHandler == null) {
            this.dataContentHandler = this.dataSource != null ? getCommandMap().createDataContentHandler(baseType, this.dataSource) : getCommandMap().createDataContentHandler(baseType);
        }
        DataSource dataSource = this.dataSource;
        if (dataSource != null) {
            this.dataContentHandler = new DataSourceDataContentHandler(this.dataContentHandler, dataSource);
        } else {
            this.dataContentHandler = new ObjectDataContentHandler(this.dataContentHandler, this.object, this.objectMimeType);
        }
        return this.dataContentHandler;
    }

    public static synchronized void setDataContentHandlerFactory(DataContentHandlerFactory dataContentHandlerFactory) {
        synchronized (DataHandler.class) {
            if (factory != null) {
                throw new Error("DataContentHandlerFactory already defined");
            }
            SecurityManager securityManager = System.getSecurityManager();
            if (securityManager != null) {
                try {
                    securityManager.checkSetFactory();
                } catch (SecurityException e) {
                    if (DataHandler.class.getClassLoader() != dataContentHandlerFactory.getClass().getClassLoader()) {
                        throw e;
                    }
                }
            }
            factory = dataContentHandlerFactory;
        }
    }

    public CommandInfo[] getAllCommands() {
        return this.dataSource != null ? getCommandMap().getAllCommands(getBaseType(), this.dataSource) : getCommandMap().getAllCommands(getBaseType());
    }

    public Object getBean(CommandInfo commandInfo) {
        try {
            ClassLoader contextClassLoader = SecuritySupport.getContextClassLoader();
            if (contextClassLoader == null) {
                contextClassLoader = getClass().getClassLoader();
            }
            return commandInfo.getCommandObject(this, contextClassLoader);
        } catch (IOException | ClassNotFoundException unused) {
            return null;
        }
    }

    public CommandInfo getCommand(String str) {
        return this.dataSource != null ? getCommandMap().getCommand(getBaseType(), str, this.dataSource) : getCommandMap().getCommand(getBaseType(), str);
    }

    public Object getContent() {
        Object obj = this.object;
        return obj != null ? obj : getDataContentHandler().getContent(getDataSource());
    }

    public String getContentType() {
        DataSource dataSource = this.dataSource;
        return dataSource != null ? dataSource.getContentType() : this.objectMimeType;
    }

    public DataSource getDataSource() {
        DataSource dataSource = this.dataSource;
        if (dataSource == null) {
            if (this.objDataSource == null) {
                this.objDataSource = new DataHandlerDataSource(this);
            }
            return this.objDataSource;
        }
        return dataSource;
    }

    public InputStream getInputStream() {
        DataSource dataSource = this.dataSource;
        if (dataSource != null) {
            return dataSource.getInputStream();
        }
        final DataContentHandler dataContentHandler = getDataContentHandler();
        if (dataContentHandler == null) {
            throw new UnsupportedDataTypeException("no DCH for MIME type " + getBaseType());
        } else if ((dataContentHandler instanceof ObjectDataContentHandler) && ((ObjectDataContentHandler) dataContentHandler).getDCH() == null) {
            throw new UnsupportedDataTypeException("no object DCH for MIME type " + getBaseType());
        } else {
            final PipedOutputStream pipedOutputStream = new PipedOutputStream();
            PipedInputStream pipedInputStream = new PipedInputStream(pipedOutputStream);
            new Thread(new Runnable() { // from class: javax.activation.DataHandler.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        dataContentHandler.writeTo(DataHandler.this.object, DataHandler.this.objectMimeType, pipedOutputStream);
                    } catch (IOException unused) {
                    } catch (Throwable th) {
                        try {
                            pipedOutputStream.close();
                        } catch (IOException unused2) {
                        }
                        throw th;
                    }
                    try {
                        pipedOutputStream.close();
                    } catch (IOException unused3) {
                    }
                }
            }, "DataHandler.getInputStream").start();
            return pipedInputStream;
        }
    }

    public String getName() {
        DataSource dataSource = this.dataSource;
        if (dataSource != null) {
            return dataSource.getName();
        }
        return null;
    }

    public OutputStream getOutputStream() {
        DataSource dataSource = this.dataSource;
        if (dataSource != null) {
            return dataSource.getOutputStream();
        }
        return null;
    }

    public CommandInfo[] getPreferredCommands() {
        return this.dataSource != null ? getCommandMap().getPreferredCommands(getBaseType(), this.dataSource) : getCommandMap().getPreferredCommands(getBaseType());
    }

    public Object getTransferData(DataFlavor dataFlavor) {
        return getDataContentHandler().getTransferData(dataFlavor, this.dataSource);
    }

    public synchronized DataFlavor[] getTransferDataFlavors() {
        if (factory != this.oldFactory) {
            this.transferFlavors = emptyFlavors;
        }
        if (this.transferFlavors == emptyFlavors) {
            this.transferFlavors = getDataContentHandler().getTransferDataFlavors();
        }
        return this.transferFlavors;
    }

    public boolean isDataFlavorSupported(DataFlavor dataFlavor) {
        for (DataFlavor dataFlavor2 : getTransferDataFlavors()) {
            if (dataFlavor2.equals(dataFlavor)) {
                return true;
            }
        }
        return false;
    }

    public synchronized void setCommandMap(CommandMap commandMap) {
        if (commandMap != this.currentCommandMap || commandMap == null) {
            this.transferFlavors = emptyFlavors;
            this.dataContentHandler = null;
            this.currentCommandMap = commandMap;
        }
    }

    public void writeTo(OutputStream outputStream) {
        DataSource dataSource = this.dataSource;
        if (dataSource == null) {
            getDataContentHandler().writeTo(this.object, this.objectMimeType, outputStream);
            return;
        }
        byte[] bArr = new byte[8192];
        InputStream inputStream = dataSource.getInputStream();
        while (true) {
            try {
                int read = inputStream.read(bArr);
                if (read <= 0) {
                    return;
                }
                outputStream.write(bArr, 0, read);
            } finally {
                inputStream.close();
            }
        }
    }
}
