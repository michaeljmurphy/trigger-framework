/**********************************************************************
 Name:  VirtualTrigger
 Copyright � 2015
 ======================================================
======================================================
 * DESC: Class to control dispatch and flow of all trigger logic.  This dispatcher class
 *       should be used to execute all trigger helper classes by adding them to the 
 *       operation stack.  This class is virtual in case we need to modify and extend functionality
 *       later if necessary.
-------                                                             
======================================================
======================================================
History                                                            
-------                                                            
VERSION      AUTHOR                DATE             DETAIL             Description
   1.0    Michael Murphy        09/09/2015     INITIAL DEVELOPMENT        
***********************************************************************/  

/*
 * USAGE: an instance of VirtualTrigger should be instantiated and addOperation should
 *        be chained in order to add functionality to the trigger.  triggers should finally
 *        call the dispatch method in order to execute all functionality.
 *
 *        E.G. *********************************************************************************************
 *               VirtualTrigger d = new VirtualTrigger();                   // instantiate
 *               d.addOperation(new MM_ExampleClass_TH(Trigger.newMap, Trigger.oldMap))     // add first operation 
 *                .addOperation(new MM_AnotherClass_TH(Trigger.newMap, Trigger.oldMap));    // chain further operations
 *               d.dispatch();                                                              // dispatch the queue to be executed
 *             *********************************************************************************************
 *
 * */
 
 


public virtual class VirtualTrigger {
    /* operations to be completed by the dispatcher */
    private List<ITrigger> operations;

    /* basic instantiation of the class should initialise the op list */
    public VirtualTrigger () { 
        this.operations = new List<ITrigger>();
    }
    
    /* add an operation to the queue - chainable */ 
    public VirtualTrigger addOperation (ITrigger op) {
        
        operations.add(op);
        return this;
    }
    
    /* dispatch all operations in the queue */
    public void dispatch() {
        
        // @TODO: handle different trigger contexts to stop errors happening and
        //        reduction in trigger if else statements
        
        if(!operations.isEmpty()) {
            for (ITrigger op : operations) { 
                try {
                    op.filterRecords(); 
                    op.execute();
                } catch (Exception e) {
                    ChatterExceptionLogger.asyncInsertException(String.valueOf(op).split(':')[0]
                                                                , String.valueOf(e.getLineNumber())
                                                                , e.getMessage());
                    throw new VirtualTriggerException('Trigger Error: ' + e.getMessage());
                }
            }
        }
    }

    public class VirtualTriggerException extends Exception {}
}