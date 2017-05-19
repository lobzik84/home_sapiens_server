package org.inet.filetools;

import java.io.*;
import java.net.URI;
import java.nio.channels.SeekableByteChannel;
import java.nio.file.Files;
import java.nio.file.Paths;
import static java.nio.file.StandardOpenOption.READ;
import java.util.Properties;
import java.util.concurrent.TimeUnit;
import org.lobzik.tools.Tools;
import static org.inet.filetools.UuidGenerator.*;

/**
 * ����� ������������� ����������� ��� ������ � �������� ��������. ����������� ��� ������ � �������� �������� ���������� ��������� ������, ������������ ������� ����� �� ����� ��� ������ � �������� ��
 * ������ ���������� ���������� ������, ������������� � ������� ����������������� �����
 *
 * @version 2.1
 * @author ������ �������
 */
public class FileTools {

	private boolean initialized = false;
	private String appRootFolderPath = "";
	private String configTempExtension = "tmp";
	private long configBufferLength = 1048576;
	private int configSecondsTimeout = 20;
	private String configRootFolderPath = "";
	private String configSuperTTOKReply = "";
	private String configWindowsCodeword = "";
	private String configWindowsMountCommandPattern = "";
	private String configMacOSCodeword = "Mac OS X";
	private String configMacOSMountCommandPattern = "";
	private String configUnixMountCommandPattern = "";
	private String configUnixMountCommandUidOverridePattern = "";
	private boolean configUidOverride = false;
	private String configUnixMountPoint = "";
	private String configUnixMKDIRCommandPattern = "";
	private String configHost = "";
	private String configShareName = "";
	private String configShareNfsName = "";
	private String configShareUsername = "";
	private String configSharePassword = "";
	private String configShareUnixUid = "";
	private Properties properties = null;
	private int mountTries = 0;

	private FileTools() {
	}

	/**
	 * �����������. ��������� ������������� ������, ��������� ���������������� ��������� �� �����
	 *
	 * @param filetoolsPropsFile - ���� � �������������
	 * @throws Exception
	 */
	public FileTools(File filetoolsPropsFile, String storageFolder, String host, String shareName, String shareNfsName, String mountPoint) throws Exception {
		configHost = host;
		configShareName = shareName;
		configShareNfsName = shareNfsName;
		configUnixMountPoint = mountPoint;
		configRootFolderPath = storageFolder;
		if (filetoolsPropsFile != null && filetoolsPropsFile.canRead()) {
			properties = new Properties();
			try (FileInputStream fis = new FileInputStream(filetoolsPropsFile)) {
				properties.load(fis);
			}
			init(properties);
			mount();
		} else {
			throw new Exception("Can't read properties file!");
		}
	}

	/**
	 * �����������. ��������� ������������� ������, ��������� ���������������� ��������� �� �����
	 *
	 * @param filetoolsPropsFile - ���� � �������������
	 * @throws Exception
	 */
	public FileTools(File filetoolsPropsFile, String storageFolder) throws Exception {
		configRootFolderPath = storageFolder;
		if (filetoolsPropsFile != null && filetoolsPropsFile.canRead()) {
			properties = new Properties();
			try (FileInputStream fis = new FileInputStream(filetoolsPropsFile)) {
				properties.load(fis);
			}
			init(properties);
			mount();
		} else {
			throw new Exception("Can't read properties file!");
		}
	}

	/**
	 * �����������. ��������� ������������� ������, ��������� ���������������� ��������� �� �����
	 *
	 * @param filetoolsProps - ������������
	 * @throws Exception
	 */
	public FileTools(Properties filetoolsProps) throws Exception {
		properties = filetoolsProps;
		init(filetoolsProps);
		mount();
	}


	private void init(Properties filetoolsProps) throws Exception {
		configTempExtension = filetoolsProps.getProperty("filetools.temp_extension");
		configBufferLength = Tools.parseInt(filetoolsProps.getProperty("filetools.buffer_length"), 1048576);
		configSecondsTimeout = Tools.parseInt(filetoolsProps.getProperty("filetools.seconds_timeout"), 20);

		if (configRootFolderPath.length() == 0) {
			configRootFolderPath = filetoolsProps.getProperty("filetools.application.rootfolder");
		}

		configSuperTTOKReply = filetoolsProps.getProperty("filetools.supertt_ok_reply");

		configWindowsCodeword = filetoolsProps.getProperty("filetools.windows.codeword");
		configWindowsMountCommandPattern = filetoolsProps.getProperty("filetools.windows.mount_command_pattern");

		configUnixMountCommandPattern = filetoolsProps.getProperty("filetools.nfs.mount_command_pattern");//filetoolsProps.getProperty("filetools.unix.mount_command_pattern");
		configUnixMountCommandUidOverridePattern = filetoolsProps.getProperty("filetools.unix.mount_command_uid_override_pattern");

		configMacOSCodeword = (String)Tools.isNull(filetoolsProps.getProperty("filetools.macos.codeword"), configMacOSCodeword);
		configMacOSMountCommandPattern = filetoolsProps.getProperty("filetools.macos.mount_command_pattern");

		configUidOverride = Tools.parseInt(filetoolsProps.getProperty("filetools.unix.uid_override"), 0) == 1;
		if (configUnixMountPoint.length() == 0) {
			configUnixMountPoint = filetoolsProps.getProperty("filetools.unix.mount_point");
		}

		configUnixMKDIRCommandPattern = filetoolsProps.getProperty("filetools.unix.mkdir_command_pattern");

		if (configHost.length() == 0) {
			configHost = filetoolsProps.getProperty("filetools.share.host");
		}
		if (configShareName.length() == 0) {
			configShareName = filetoolsProps.getProperty("filetools.share.name");
		}
		if (configShareNfsName.length() == 0) {
			configShareNfsName = filetoolsProps.getProperty("filetools.nfs.share.name");
		}
		configShareUsername = filetoolsProps.getProperty("filetools.share.username");
		configSharePassword = filetoolsProps.getProperty("filetools.share.password");
		configShareUnixUid = filetoolsProps.getProperty("filetools.share.unix.uid");
		if (System.getProperty("os.name").contains(configWindowsCodeword)) {
			appRootFolderPath = "\\\\" + configHost + "\\" + configShareName + "\\" + configRootFolderPath; //���� � ����� ����������
		} else {
			if (!System.getProperty("os.name").contains(configMacOSCodeword)) {
				configShareName = configShareNfsName;
			}
			appRootFolderPath = configUnixMountPoint + "/" + configRootFolderPath; //���� � ����� ����������
			appRootFolderPath = appRootFolderPath.replace("//", "/");
		}
		initialized = true;
	}

	public FileTools getInstanceForFolder(String rootFolder) throws Exception {
		FileTools newTools = new FileTools();
		Properties newProps = (Properties) this.properties.clone();

		if (newProps.getProperty("filetools.share.host") == null) {
			newProps.setProperty("filetools.share.host", configHost);
		}
		if (newProps.getProperty("filetools.share.name") == null) {
			newProps.setProperty("filetools.share.name", configShareName);
		}
		if (newProps.getProperty("filetools.nfs.share.name") == null) {
			newProps.setProperty("filetools.nfs.share.name", configShareNfsName);
		}
		if (newProps.getProperty("filetools.unix.mount_point") == null) {
			newProps.setProperty("filetools.unix.mount_point", configUnixMountPoint);
		}
		newProps.setProperty("filetools.application.rootfolder", rootFolder);
		newTools.init(newProps);
		return newTools;
	}

	/**
	 * ����� ����������, ��� ����� �� �������� ����������, � �������� �������������� ����� ������������ �������.
	 *
	 * @throws Exception
	 */
	private void mount() throws Exception {
		mountTries++;
		if (!initialized) {
			throw new Exception("initialize config params before mounting!");
		}
		/*if (mountTries > configMaxInitTries)
		 throw new Exception("max mount tries exceeded!"); */
		String os = System.getProperty("os.name");
		if (os.contains(configWindowsCodeword)) {
			mountWin();
		} else if (os.contains(configMacOSCodeword)) {
			mountMacOS();
		} else {
			mountUnix();
		}
	}

	/**
	 * ���������� ��� ������������ ������� � Windows
	 *
	 * @throws Exception
	 */
	private void mountWin() throws Exception {
		if (checkFolder(appRootFolderPath)) {
			return; //���� �������� - ������������
		}    //net use \\\\@hostname\\@sharename\\@rootfolder @password /user:@user
		String commandLine = configWindowsMountCommandPattern.replaceAll("%hostname%", configHost);
		commandLine = commandLine.replaceAll("%sharename%", configShareName);
		commandLine = commandLine.replaceAll("%rootfolder%", configRootFolderPath);
		commandLine = commandLine.replaceAll("%password%", configSharePassword);
		commandLine = commandLine.replaceAll("%user%", configShareUsername);
		execStr(commandLine); //���� ��� - �������� ������������
		if (!checkFolder(appRootFolderPath)) {
			throw new Exception("Mounting Samba drive unsuccesfully");
		}
	}

	/**
	 * ���������� ��� ������������ ������� � Unix
	 *
	 * @throws Exception
	 */
	private void mountUnix(String commandPattern) throws Exception {
		if (checkFolder(appRootFolderPath)) {
			return; //���� � ��� ��� �������� - ������������
		}
		if (!checkFolder(configUnixMountPoint)) //���� ����� ���� ����� ������������
		{
			String commandLine = configUnixMKDIRCommandPattern.replaceAll("%dirname%", configUnixMountPoint);
			execStr(commandLine); //�������
		}
		///bin/mount.cifs //%hostname%/%sharename% %mountpoint% -o user=%user% -o password=%password%
		String commandLine = commandPattern.replaceAll("%hostname%", configHost);
		commandLine = commandLine.replaceAll("%sharename%", configShareName);
		commandLine = commandLine.replaceAll("%mountpoint%", configUnixMountPoint);
		commandLine = commandLine.replaceAll("%rootfolder%", configRootFolderPath);
		commandLine = commandLine.replaceAll("%user%", configShareUsername); //������� ������� ������������
		commandLine = commandLine.replaceAll("%password%", configSharePassword);
		if (configUidOverride) {
			commandLine += configUnixMountCommandUidOverridePattern;
			commandLine = commandLine.replaceAll("%uid%", configShareUnixUid);
		}
		execStr(commandLine); //���������
		if (!checkFolder(appRootFolderPath)) {
			throw new Exception("Mounting linux/macos share drive unsuccesfully");
		}
	}

	private void mountUnix() throws Exception {
		mountUnix(configUnixMountCommandPattern);
	}

	private void mountMacOS() throws Exception {
		mountUnix(configMacOSMountCommandPattern);
	}

	/**
	 * ����� �������� ������� ����������� ����, � ���������� ����� (stdout ��� stderr ��� ������) ���������� � ���� ������.
	 *
	 * @param commandLine - ������� ��� ����������
	 * @return
	 * @throws Exception
	 */
	private String execStr(String commandLine) throws Exception {
		String os = System.getProperty("os.name");
		boolean isWin = os.contains(configWindowsCodeword);
		Process process = Runtime.getRuntime().exec(commandLine + "\n");

		String retString;
		String errString;

		process.waitFor(configSecondsTimeout, TimeUnit.SECONDS);
		try (InputStream in = process.getInputStream()) {
			int size = in.available();
			if (size > 0) {
				byte[] msg = new byte[size];
				in.read(msg);
				retString = isWin ? new String(msg) : new String(msg, "utf-8");
			} else {
				retString = "";
			}
		}

		try (InputStream in = process.getErrorStream()) {
			int size = in.available();
			if (size > 0) {
				byte[] msg = new byte[size];
				in.read(msg);
				errString = isWin ? new String(msg) : new String(msg, "utf-8");
			} else {
				errString = "";
			}
		}
		int retCode = process.exitValue();

		if (retCode != 0) {
			throw new Exception("Invalid operation: " + commandLine + " returned non-zero return code: " + retCode + " (" + errString + "," + retString + ")");
		}
		return retString;
	}

	/**
	 * �� ����������� �������� ������ ������� � ���������� ����, ��������� ��� ���������� ��� ���������� ��� ���
	 *
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public String addFile(InputStream is) throws IOException {
		String UID = generate(this);
		return (addFile(is, UID));
	}

	/**
	 * ������� ��������� ���������� �������� �����
	 *
	 * @param name
	 * @throws IOException
	 */
	public void removeTempExt(String name) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		File file = new File(appRootFolderPath, name + "." + configTempExtension);
		File file2 = new File(appRootFolderPath, name);
		if (file2.exists()) {
			file2.delete();
		}
		file.renameTo(file2);
	}

	public String getTempExtension() {
		return (configTempExtension);
	}

	public void removeTempExt(String folder, String name) throws IOException {
		if (System.getProperty("os.name").contains("Windows")) {
			removeTempExt(folder + "\\" + name);
		} else {
			removeTempExt(folder + "/" + name);
		}
	}

	/**
	 * �� ����������� �������� ������ ������� � ���������� ���� ��� �������� ������ ������� ���� ��������� � ��������� �����������, �� ��������� �������� ���� ����������������� ���������� ��� ���
	 *
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public String addFile(InputStream is, String name) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		try (BufferedInputStream bis = new BufferedInputStream(is)) {
			String UID = name;
			File file = new File(appRootFolderPath, UID + "." + configTempExtension);
			try (FileOutputStream fos = new FileOutputStream(file)) {
				rewriteStreams(bis, fos);
				fos.flush();
			} catch (Exception e) {
				file.delete();
				throw e;
			}
			file.renameTo(new File(appRootFolderPath, UID));
			return UID;
		} catch (IOException ioe) {
			throw ioe;
		}
	}

	public void getCacheImageFile(String UID, String folder, OutputStream os) throws Exception {
		if (System.getProperty("os.name").contains("Windows")) {
			folder = appRootFolderPath + "\\" + folder;
		} else {
			folder = appRootFolderPath + "/" + folder;
		}

		if (!checkFolder(folder)) {
			throw new IOException("Folder not found!");
		}
		try {
			File file = new File(folder, UID);
			try (FileInputStream fis = new FileInputStream(file)) {
				if (!file.isFile()) {
					throw new IOException("File not found!");
				}
				rewriteStreams(fis, os);
			}
		} catch (IOException ioe) {
			throw ioe;
		}
	}

	public boolean fileExist(String folder, String uuid) {
		if (System.getProperty("os.name").contains("Windows")) {
			folder = appRootFolderPath + "\\" + folder;
		} else {
			folder = appRootFolderPath + "/" + folder;
		}
		boolean result = false;
		try {
			File file = new File(folder, uuid);
			result = file.exists();
		} catch (Exception e) {
		}
		return result;
	}

	/**
	 * ����� ������������ ��� ���������� �������� � �������� ���������, � ��������� �����
	 *
	 * @param is
	 * @param folder
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public void deleteCacheImageFile(String folder, String name) throws Exception {
		if (!checkFolder(folder)) {
			File td = new File(folder);
			td.mkdirs();
			if (!checkFolder(folder)) {
				throw new IOException("Folder " + folder + " not found");
			}
		}
		File file = new File(folder, name);
		if (file.isFile()) {
			if (!file.delete()) {
				throw new IOException("Files not delete!");
			}
		}
	}

	/**
	 * ����� ������������ ��� ���������� �������� � �������� ���������, � ��������� �����
	 *
	 * @param is
	 * @param folder
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public String addCacheImageFile(InputStream is, String folder, String name) throws Exception {
		return addCacheImageFile1(is, folder, name).getName();
	}

	public File addCacheImageFile1(InputStream is, String folder, String name) throws Exception {
		if (System.getProperty("os.name").contains("Windows")) {
			folder = appRootFolderPath + "\\" + folder;
		} else {
			folder = appRootFolderPath + "/" + folder;
		}
		deleteCacheImageFile(folder, name);
		if (!checkFolder(folder)) {
			File td = new File(folder);
			td.mkdirs();
			if (!checkFolder(folder)) {
				throw new IOException("Folder " + folder + " not found");
			}
		}

		try (BufferedInputStream bis = new BufferedInputStream(is)) {
			String UID = name == null ? generate(this) : name;
			File file = new File(folder, UID + "." + configTempExtension);
			try (FileOutputStream fos = new FileOutputStream(file)) {
				rewriteStreams(bis, fos);
				fos.flush();
			} catch (Exception e) {
				file.delete();
				throw e;
			}
			File newFile = new File(folder, UID);
			file.renameTo(newFile);
			return newFile;
		} catch (IOException ioe) {
			throw ioe;
		}
	}

	/**
	 * ���������� ��������������� UUID
	 *
	 * @return
	 */
	public String getUID() {
		return generate(this);
	}

	/**
	 * ���������� ����� ��� ������ � ������������ ����
	 *
	 * @param name - ��� �����
	 * @return - �������� �����
	 * @throws IOException
	 */
	public OutputStream writeFile(String name) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		try {
			String UID = name;
			File file = new File(appRootFolderPath, UID + "." + configTempExtension);
			return new FileOutputStream(file);
		} catch (IOException ioe) {
			throw ioe;
		}
	}

	/**
	 * ��������� ����� �� �������� ������, � ���������� �� � ������������ ���� (������)
	 *
	 * @param name - ��� �����
	 * @param is - ������� �����
	 * @throws IOException
	 */
	public void writeFile(String name, InputStream is) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		try {
			String UID = name;
			File file = new File(appRootFolderPath, UID + "." + configTempExtension);
			try (FileOutputStream fos = new FileOutputStream(file)) {
				rewriteStreams(is, fos);
			} catch (Exception e) {
				file.delete();
				throw e;
			}
			removeTempExt(UID);
		} catch (IOException ioe) {
			throw ioe;
		}
	}

	/**
	 * ��������� ����� �� �������� ������, � ���������� �� � ������������ ���� (�������)
	 *
	 * @param name - ��� �����
	 * @param is - ������� �����
	 * @throws IOException
	 */
	public void rewriteFile(String name, InputStream is) throws IOException {
		rewriteFile(name, null, is);
	}

	public void rewriteFile(String name, String folder, InputStream is) throws IOException {
		rewriteFile(name, folder, is, false);
	}

	/**
	 * ��������� ����� �� �������� ������, � ���������� �� � ������������ ���� (�������)
	 *
	 * @param name - ��� �����
	 * @param folder �����, � ������� ����� ����, ������������ ����� ��
	 * @param is - ������� �����
	 * @throws IOException
	 */
	public void rewriteFile(String name, String folder, InputStream is, boolean addIfNotExists) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}

		String delimeter = "";
		String f = appRootFolderPath;
		if (folder != null && !folder.trim().isEmpty()) {
			if (System.getProperty("os.name").contains("Windows")) {
				delimeter = "\\";
			} else {
				delimeter = "/";
			}
			f += delimeter + folder;
		}

		try {
			String UID = name;
			File file = new File(f, UID + "." + configTempExtension);
			try (FileOutputStream fos = new FileOutputStream(file, false)) {
				rewriteStreams(is, fos);
			} catch (Exception e) {
				throw e;
			}
			removeTempExt(folder, UID);

			if (addIfNotExists && !checkFile(f + delimeter + UID)) {
				addFile(is, folder, name);
			}

		} catch (IOException ioe) {
			throw ioe;
		}
	}

	/**
	 * ���������� ������ ���� ������ � ������� �����
	 *
	 * @return
	 * @throws IOException
	 */
	public String[] getFileList() throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		File f1 = new File(appRootFolderPath);
		return (f1.list());
	}

	/**
	 * ���������� ����������� (�� �����) ���� � �������� �����
	 *
	 * @param UID
	 * @param os
	 * @throws IOException
	 */
	/**
	 * ���������� ������ ���� "����"
	 *
	 * @param UID ��� �����
	 * @return ������ ���� "����"
	 * @throws IOException
	 */
	public File getFile(String UID) throws IOException {
		return getFile(null, UID);
	}

	/**
	 * ���������� ������ ���� "����"
	 *
	 * @param folder �����, � ������� ����� ����, ������������ ����� ��
	 * @param UID ��� �����
	 * @return ������ ���� "����"
	 * @throws IOException
	 */
	public File getFile(String folder, String UID) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}

		String f = appRootFolderPath;
		if (folder != null && !folder.trim().isEmpty()) {
			if (System.getProperty("os.name").contains("Windows")) {
				f += "\\" + folder;
			} else {
				f += "/" + folder;
			}
		}

		return new File(f, UID);
	}

	/**
	 * ���������� ����������� (�� �����) ���� � �������� �����
	 *
	 * @param UID ��� �����
	 * @param os - �����, � ������� ������ ����
	 * @throws IOException
	 */
	public void getFile(String UID, OutputStream os) throws IOException {
		getFile(null, UID, os, 0);
	}

	/**
	 * ���������� ����������� (�� �����) ���� � �������� �����
	 *
	 * @param UID ��� �����
	 * @param os - �����, � ������� ������ ����
	 * @param startPosition - �������� ������ � ������ ������������ ������ �����
	 * @throws IOException
	 */
	public void getFile(String folder, String UID, OutputStream os) throws IOException {
		getFile(folder, UID, os, 0);
	}

	/**
	 * ���������� ����������� (�� �����) ���� � �������� �����
	 *
	 * @param folder �����, � ������� ����� ����, ������������ ����� ��
	 * @param UID ��� �����
	 * @param os - �����, � ������� ������ ����
	 * @param startPosition - �������� ������ � ������ ������������ ������ �����
	 * @throws IOException
	 */
	public void getFile(String UID, OutputStream os, long startPosition) throws IOException {
		getFile(null, UID, os, startPosition);
	}

	/**
	 * ���������� ����������� (�� �����) ���� � �������� �����, ������� � ��������� �������
	 *
	 * @param folder �����, � ������� ����� ����, ������������ ����� ��
	 * @param UID ��� �����
	 * @param os - �����, � ������� ������ ����
	 * @param startPosition - �������� ������ � ������ ������������ ������ �����
	 * @throws IOException
	 */
	public void getFile(String folder, String UID, OutputStream os, long startPosition) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}

		String f = appRootFolderPath;
		if (folder != null && !folder.trim().isEmpty()) {
			if (System.getProperty("os.name").contains("Windows")) {
				f += "\\" + folder;
			} else {
				f += "/" + folder;
			}
		}

		File file = new File(f, UID);
		try (FileInputStream fis = new FileInputStream(file)) {
			if (startPosition > 0) {
				fis.skip(startPosition);
			}
			if (!file.isFile()) {
				throw new IOException("File not found!");
			}
			rewriteStreams(fis, os);
		}
	}

	/**
	 * ���������� URI (������������� ������������� �������, �� ������ � ���������� �� �/� "����������� �����������") ���������� ����� � ��������� (����������������) �������� �������.
	 *
	 * @param UID ��� �����
	 * @return URI
	 * @throws IOException
	 */
	public URI getFileURI(String UID) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		File file = new File(appRootFolderPath, UID);
		return file.toURI();
	}

	/**
	 * ���������� ����� �����.
	 *
	 * @param UID ��� �����
	 * @return ���������� �����
	 * @throws IOException - ���� ���-�� �� �������
	 */
	public InputStream getFileStream(String UID) throws IOException {
		return getFileStream(null, UID);
	}

	/**
	 * ���������� ����� �����.
	 *
	 * @param folder �����, � ������� ����� ����, ������������ ����� ��
	 * @param UID ��� �����
	 * @return ���������� �����
	 * @throws IOException - ���� ���-�� �� �������
	 */
	public InputStream getFileStream(String folder, String UID) throws IOException {
		String f = appRootFolderPath;
		if (folder != null && !folder.trim().isEmpty()) {
			if (System.getProperty("os.name").contains("Windows")) {
				f += "\\" + folder;
			} else {
				f += "/" + folder;
			}
		}
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		File file = new File(f, UID);
		InputStream fis = new FileInputStream(file);
		return fis;
	}

	/**
	 * ���������� ����� �����
	 *
	 * @param UID
	 * @return
	 * @throws IOException
	 */
	public long getFileLength(String UID) throws IOException {
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		File file = new File(appRootFolderPath, UID);
		if (!file.isFile()) {
			throw new IOException("File not found!");
		}
		return (file.length());
	}

	/**
	 * ������� ��������� ����
	 *
	 * @param UID
	 * @return
	 * @throws IOException
	 */
	public boolean deleteFile(String UID) throws IOException {
		if (UID == null || UID.length() == 0) {
			return false;
		}
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		File myDir = new File(appRootFolderPath);
		FilenameFilter select = new FileListFilter(UID);
		File[] fileList = myDir.listFiles(select);
		for (File file : fileList) {
			if (!file.isFile()) {
				continue;//throw new IOException("File not found!");
			}
			if (!file.delete()) {
				throw new IOException("Files not delete!");
			}
		}
		return true;
	}

	/**
	 * �������������� ������. �� �������� � ��������, �������. ����� - ������ - ������������� ������� ���������. ���������� ��������� ������, � ���������� ���������� - ������� ������� �������� ���.
	 *
	 * @param is
	 * @param os
	 * @throws IOException
	 */
	private void rewriteStreams(InputStream is, OutputStream os) throws IOException {
		long bufferLength = configBufferLength;
		byte[] buff = new byte[(int) bufferLength];
		int count;
		while ((count = is.read(buff)) != -1) {
			os.write(buff, 0, count);
		}
	}

	/**
	 * ���������� ������ � ���������� (��� �������) - ���� �� ������, �� "iamok" (������� �������������), ���� �� ������� ����������������� ������� - �������� ������������, ��� ������� ����������
	 * ����� ����������.
	 *
	 * @return ������ � ����������
	 */
	public String getTTStatus() {
		try {
			if (checkConnection()) {
				return configSuperTTOKReply;
			} else {
				return "Filetools not ready";
			}
		} catch (Exception e) {
			return "Error: " + e.getMessage();
		}
	}

	/**
	 * @return �������� ����� ����������
	 */
	public String getRootFolder() {
		return configRootFolderPath;
	}

	public void createFolder(String folder) throws IOException {
		String finalFolder = appRootFolderPath;
		if (!folder.startsWith(appRootFolderPath)) {
			if (System.getProperty("os.name").contains("Windows")) {
				finalFolder += "\\" + folder;
			} else {
				finalFolder += "/" + folder;
			}
		}
		if (!checkFolder(finalFolder)) {
			File td = new File(finalFolder);
			td.mkdirs();
			if (!checkFolder(finalFolder)) {
				throw new IOException("Folder " + folder + " not found");
			}
		}
	}

	/**
	 * ��������� ����������� ���������� � �������� ��������, ���� ��� - �������� ������������
	 *
	 * @return
	 */
	private boolean checkConnection() throws IOException {
		if (checkFolder(appRootFolderPath)) {
			return true;
		} else if (initialized) {
			try {
				mount();
				return true;
			} catch (Exception e) {
				throw new IOException(e.getMessage());
			}
		} else {
			throw new IOException("Tryin' to use not-initialized filetools!");
		}

	}

	/**
	 * ��������� ������� �����.
	 *
	 * @param path
	 * @return
	 */
	private boolean checkFolder(String path) {
		try {
			File f1 = new File(path);
			return f1.isDirectory();
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * ��������� ������� �����.
	 *
	 * @param path
	 * @return
	 */
	private boolean checkFile(String path) {
		try {
			File f1 = new File(path);
			return f1.isFile();
		} catch (Exception e) {
			return false;
		}
	}

	class FileListFilter implements FilenameFilter {

		private final String name;

		public FileListFilter(String name) {
			this.name = name;
		}

		public boolean accept(File directory, String filename) {
			boolean fileOK = true;
			if (name != null) {
				fileOK &= filename.startsWith(name);
			}
			return fileOK;
		}
	}

	/**
	 * ����� ������������ ��� ������ ������ � ��������� ����� ��������� ���������
	 *
	 * @param is
	 * @param folder
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public String addFile(InputStream is, String folder, String name) throws IOException {

		createFolder(folder);

		if (System.getProperty("os.name").contains("Windows")) {
			folder = appRootFolderPath + "\\" + folder;
		} else {
			folder = appRootFolderPath + "/" + folder;
		}

		try (BufferedInputStream bis = new BufferedInputStream(is)) {
			String UID = name == null ? generate(this) : name;
			File file = new File(folder, UID + "." + configTempExtension);
			try (FileOutputStream fos = new FileOutputStream(file)) {
				rewriteStreams(bis, fos);
				fos.flush();
			} catch (Exception e) {
				file.delete();
				throw e;
			}
			file.renameTo(new File(folder, UID));
			return UID;
		} catch (IOException ioe) {
			throw ioe;
		}
	}

	/**
	 * ����� ������������ ��� �������� ������ �� ��������� ����� ��������� ���������
	 *
	 * @param folder
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public void deleteFile(String folder, String name) throws IOException {
		String f;
		if (System.getProperty("os.name").contains("Windows")) {
			f = appRootFolderPath + "\\" + folder;
		} else {
			f = appRootFolderPath + "/" + folder;
		}
		File file = new File(f, name);
		if (file.isFile()) {
			if (!file.delete()) {
				throw new IOException("Files not delete!");
			}
		}
	}

	public SeekableByteChannel getChannel(String folder, String UID) throws IOException {
		String f;
		if (folder != null && !folder.isEmpty()) {
			if (System.getProperty("os.name").contains("Windows")) {
				f = appRootFolderPath + "\\" + folder;
			} else {
				f = appRootFolderPath + "/" + folder;
			}
		} else {
			f = appRootFolderPath;
		}
		if (!checkConnection()) {
			throw new IOException("Root folder not found!");
		}
		return Files.newByteChannel(Paths.get(f, UID), READ);
	}

	public boolean moveFile(String startFolder, String finishFolder, String UID) throws IOException {
		if (UID.length() == 0) {
			return false;
		}

		if (!checkFolder(finishFolder)) {
			createFolder(finishFolder);
		}

		if (System.getProperty("os.name").contains("Windows")) {
			startFolder = appRootFolderPath + "\\" + startFolder.replaceAll("/", "\\\\");
			finishFolder = appRootFolderPath + "\\" + finishFolder.replaceAll("/", "\\\\");
		} else {
			startFolder = appRootFolderPath + "/" + startFolder;
			finishFolder = appRootFolderPath + "/" + finishFolder;
		}
                
		File file = new File(startFolder, UID);
		File destFile = new File(finishFolder, UID);
		return file.renameTo(destFile);
	}

}
