package org.inet.mail;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;


public class MailerMessage {

	private final String subject;
	private final String body;
	private final String encoding;
	private final boolean isHTML;
	private final InternetAddress from;
	private final InternetAddress[] to;

	public MailerMessage(String subject, String body, String from, String to, String encoding, boolean isHTML) throws AddressException {
		this.subject = subject;
		this.body = body;
		this.from = new InternetAddress(from);
		this.to = InternetAddress.parse(to.replace(";", ","));
		this.encoding = encoding;
		this.isHTML = isHTML;
	}

	public String getSubject() {
		return subject;
	}

	public String getBody() {
		return body;
	}

	public InternetAddress getFrom() {
		return from;
	}

	public InternetAddress[] getTo() {
		return to;
	}

	public String getEncoding() {
		return encoding;
	}

	public boolean isHTML() {
		return isHTML;
	}

}
