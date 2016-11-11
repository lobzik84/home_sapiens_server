package org.inet.mail;

import java.util.Properties;
import org.lobzik.tools.Tools;

/**
 * ����� ���������� �������� ��� �������� �����
 *
 * @author ������ �������, ������ �������
 */
public class MailerProperties extends Properties {

	public MailerProperties(String host) {
		setHost(host);
		setPort(25);
		setAuthRequired(false);
		setSslRequired(false);
	}

	public MailerProperties(String host, int port) {
		setHost(host);
		setPort(port);
		setAuthRequired(false);
		setSslRequired(false);
	}

	public final void setHost(String host) {
		setProperty("mail.smtp.host", host);
	}

	public final String getHost() {
		return getProperty("mail.smtp.host");
	}

	public final void setPort(int port) {
		this.put("mail.smtp.port", port);
	}

	public final int getPort() {
		return Tools.parseInt(this.get("mail.smtp.port"), 25);
	}

	public final void setAuthRequired(boolean auth) {
		this.put("mail.smtp.auth", "" + auth);
	}

	public final boolean getAuthRequired() {
		return Tools.parseBoolean(this.get("mail.smtp.auth"), false);
	}

	public final void setSslRequired(boolean ssl) {
		if (ssl) {
			put("mail.smtp.starttls.enable", "true");
			put("mail.smtp.ssl.enable", "true");
			put("mail.smtp.ssl.trust", "*");
		} else {
			put("mail.smtp.starttls.enable", "false");
			put("mail.smtp.ssl.enable", "false");
			remove("mail.smtp.ssl.trust");
		}
	}

	public final boolean getSslRequired() {
		return Tools.parseBoolean(this.get("mail.smtp.ssl.enable"), false);
	}
}
