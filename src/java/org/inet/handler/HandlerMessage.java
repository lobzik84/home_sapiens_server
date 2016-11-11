package org.inet.handler;

/**
 *
 * @author Dmitry G.
 */
public class HandlerMessage {
    
    private final Priority     priority;
    private final Object       message;
    
    private int id = -1;
    
    public enum Priority {
        NORMAL, 
        HIGH
    }
    
    public static final class Builder {

			private Object message;
			private Priority priority;

			public Builder() {
				this.priority = Priority.NORMAL;
			}

			public Builder setPriority(Priority priority) {
				this.priority = priority;
				return this;
			}

			public Builder setMessage(Object message) {
				this.message = message;
				return this;
			}

			public HandlerMessage build() {
				return new HandlerMessage(this);
			}

    }

    private HandlerMessage(Builder builder) {
        this.message = builder.message;
        this.priority = builder.priority;
    }
        
    public Object getMessage() {
        return this.message;
    }
    
    public Priority getPriority() {
        return this.priority;
    }
    
    public boolean isPriorityHigh() {
        return (this.priority == Priority.HIGH);
    }
    
    protected void setId(int id) {
        this.id = id;
    }
    
    public int getId() {
        return id;
    }
    
}
