package org.inet.handler;

import java.util.concurrent.PriorityBlockingQueue;

/**
 *
 * @author Dmitry G.
 */
public class Handler implements Runnable {

    private final HandlerCallback callback;
    private final PriorityBlockingQueue<HandlerMessage> queueList;
    private boolean threadWaiting;
    
    public Handler(HandlerCallback _callback) {
        callback = _callback;
        threadWaiting = false;
        queueList = new PriorityBlockingQueue(10, new HandlerComparator());
        threadStart();
    }

    @Override
    public void run() {
        while (true) {
            if (queueList.size() > 0) {
                callback.execute(queueList.remove());
            } else {
                threadWait();
            }
        }
    }

    public void handleMessage(HandlerMessage message) {
        message.setId(queueList.size() + 1);
        queueList.add(message);
        threadNotify();
    }

    private void threadStart() {
        new Thread(this).start();
    }
    
    private void threadWait() {
        synchronized (this) {
            try {
                threadWaiting = true;
                wait();
            } catch (InterruptedException ex) {
            }
        }
    }

    private void threadNotify() {
        synchronized (this) {
            if (threadWaiting) {
                notify();
                threadWaiting = false;
            }
        }
    }

    public boolean isRunning() {
        return threadWaiting;
    }
    
    public int getQueueSize() {
        return queueList.size();
    }
    
}
