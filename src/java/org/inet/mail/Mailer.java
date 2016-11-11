package org.inet.mail;

import javax.mail.*;
import javax.mail.internet.*;
import org.inet.handler.Handler;
import org.inet.handler.HandlerMessage;


public class Mailer {

	private final Handler mailHandler;
	private final MailerProperties props;

	private boolean requireAuth = false;
	private boolean requireSsl = false;
	private String user, pass;
	private String defaultSender = "noreply@molnet.ru";
	private String defaultEncoding = "UTF-8";

	public Mailer(String host) {
		this(host, 25, false, null, null, null, null);
	}

	public Mailer(String host, String encoding) {
		this(host, 25, false, null, null, encoding, null);
	}
	
	public Mailer(String host, String encoding, String sender) {
		this(host, 25, false, null, null, encoding, sender);
	}

	public Mailer(String host, int port) {
		this(host, port, port == 465, null, null, null, null);
	}

	public Mailer(String host, int port, String encoding) {
		this(host, port, port == 465, null, null, encoding, null);
	}

	public Mailer(String host, int port, String user, String password) {
		this(host, port, port == 465, user, password, null, null);
	}

	public Mailer(String host, int port, String user, String password, String encoding) {
		this(host, port, port == 465, user, password, null, null);
	}

	public Mailer(String host, int port, String user, String password, String encoding, String sender) {
		this(host, port, port == 465, user, password, encoding, sender);
	}

	public Mailer(String host, int port, boolean requireSsl, String user, String password, String encoding, String sender) {
		this.props = new MailerProperties(host, port);
		this.user = user;
		this.pass = password;
		if (sender != null) {
			this.defaultSender = sender;
		}
		this.requireAuth = user != null && password != null;
		this.requireSsl = requireSsl;
		if (encoding != null) {
			this.defaultEncoding = encoding;
		}

		this.props.setAuthRequired(this.requireAuth);
		this.props.setSslRequired(this.requireSsl);

		mailHandler = new Handler((HandlerMessage hm) -> {
			MailerMessage m = (MailerMessage) hm.getMessage();
			try {
				doSendMessage(m);
			} catch (Exception e) {
				e.printStackTrace(System.err);
			}
		});
	}

	private void doSendMessage(MailerMessage m) throws MessagingException {
		Session session = createSession();
		MimeMessage message = new MimeMessage(session);
		message.setFrom(m.getFrom());
		message.setRecipients(Message.RecipientType.TO, m.getTo());
		message.setSubject(m.getSubject(), m.getEncoding());
		MimeBodyPart mbp = new MimeBodyPart();
		if (m.isHTML()) {
			mbp.setContent(m.getBody(), "text/html; charset=" + m.getEncoding());
		} else {
			mbp.setText(m.getBody(), m.getEncoding());
		}
		MimeMultipart mp = new MimeMultipart();
		mp.addBodyPart(mbp);
		message.setContent(mp);
		Transport transport = session.getTransport();
		transport.connect();
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
	}

	private Session createSession() {
		if (requireAuth) {
			return Session.getInstance(props, new javax.mail.Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(user, pass);
				}
			});
		} else {
			return Session.getInstance(props);
		}
	}

	public void send(String subject, String body, String from, String recepients, String encoding, boolean isHtml, boolean isAsync) throws AddressException, MessagingException {
		MailerMessage mes = new MailerMessage(subject, body, from, recepients, encoding, isHtml);
		if (isAsync) {
			mailHandler.handleMessage(new HandlerMessage.Builder().setMessage(mes).build());
		} else {
			doSendMessage(mes);
		}
	}

	public void send(String subject, String body, String recepients, boolean isHtml, boolean isAsync) throws AddressException, MessagingException {
		send(subject, body, defaultSender, recepients, defaultEncoding, isHtml, isAsync);
	}

	public void send(String subject, String body, String recepients, boolean isAsync) throws AddressException, MessagingException {
		send(subject, body, defaultSender, recepients, defaultEncoding, true, isAsync);
	}

	public void send(String subject, String body, String recepients) throws AddressException, MessagingException {
		send(subject, body, defaultSender, recepients, defaultEncoding, true, false);
	}

}
