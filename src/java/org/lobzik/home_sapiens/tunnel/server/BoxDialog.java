/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lobzik.home_sapiens.tunnel.server;

import java.util.concurrent.ThreadLocalRandom;
import org.json.JSONObject;

/**
 *
 * @author lobzik
 */
public class BoxDialog {

    public int id;
//    private Object sender;
    private JSONObject requestJson;
    public JSONObject responseJson = null;

    public BoxDialog(JSONObject request) {
        id = ThreadLocalRandom.current().nextInt();
        //this.sender = sender;
        this.requestJson = request;

    }

    public BoxDialog doDialog(BoxLink boxLink) throws Exception {
        long start = System.currentTimeMillis();
        if (boxLink.busy.get()) {
            //boxLink.queue.add(this);
            try {
                synchronized (this) {
                    //System.out.println("queueing request! id=" + id);
                    wait(BoxLink.QUEUE_TIMEOUT); //for queue
                    //System.out.println("resumed");
                }
            } catch (InterruptedException ioe) {
            }
            if (System.currentTimeMillis() - start >= BoxLink.QUEUE_TIMEOUT) {
                setError("Timeout waiting for queue");
                return this;
            }
        }
        boxLink.busy.set(true);
        try {
            switch (boxLink.status) {
                case ONLINE:
                    boxLink.session.getBasicRemote().sendText(requestJson.toString());
                    //System.out.println(" request id=" + id);

                    // System.out.println("sent text: " + requestJson.toString());
                    start = System.currentTimeMillis();
                    try {
                        synchronized (this) {
                            wait(BoxLink.RESPONSE_TIMEOUT); //for reply
                        }
                    } catch (InterruptedException ioe) {
                    }
                    boxLink.busy.set(false);

                    if (System.currentTimeMillis() - start >= BoxLink.RESPONSE_TIMEOUT) {
                        setError("Timeout waiting for response");
                    }

                    break;

                default:
                    boxLink.busy.set(false);
                    setError("Link not ready. Status is " + boxLink.status.toString());
            }
        } catch (Throwable e) {
            setError(e.getMessage());
        } finally {
            boxLink.busy.set(false);
        }
        return this;
    }

    public void resume() {

        try {
            synchronized (this) {
                notify();
            }
        } catch (Exception e) {
        }
    }

    public void gotResponse(JSONObject response) {
        this.responseJson = response;
       // System.out.println("got response id=" + id);
        resume();

    }

    private void setError(String message) {
        JSONObject response = new JSONObject();
        response.put("result", "error");
        response.put("message", message);
        responseJson = response;
    }
}
