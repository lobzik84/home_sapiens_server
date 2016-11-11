package org.inet.handler;

import java.util.Comparator;

/**
 *
 * @author Dmitry G.
 */
public class HandlerComparator implements Comparator<HandlerMessage> {   
    
    @Override
    public int compare(HandlerMessage val1, HandlerMessage val2) {
        return (val1.isPriorityHigh() == val2.isPriorityHigh()) ? 
               (Integer.valueOf(val1.getId()).compareTo(val2.getId())) : 
               (val1.isPriorityHigh() ? -1 : 1);
    }

}
