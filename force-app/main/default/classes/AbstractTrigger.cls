/**********************************************************************
 Name:  AbstractTrigger
 Copyright © 2015
 ======================================================
======================================================
  * DESC: Abstract class that all trigger helper classes should extend.  Forces
  *       trigger helpers to implement filterRecords() and execute().  Also
  *       provides some helpful variables to reduce clutter and repetitiveness in classes.
  *
-------                                                             
======================================================
======================================================
History                                                            
-------                                                            
VERSION      AUTHOR                DATE             DETAIL             Description
   1.0    Michael Murphy        09/09/2015     INITIAL DEVELOPMENT        
***********************************************************************/  
 
 public abstract class AbstractTrigger implements ITrigger {
    public enum TriggerContext { BEFOREUPDATE, AFTERUPDATE, BEFOREINSERT, AFTERINSERT }
    public TriggerContext context;
    public static Boolean recurseFlag = false;
    
    /* list of operations to be completed by the dispatcher */
    private List<ITrigger> operations = new List<ITrigger>();
    
    /* variables that can be used to hold the initial trigger lists */
    protected Map<Id, SObject> newTrig = new Map<Id, SObject>();
    protected Map<Id, SObject> oldTrig = new Map<Id, SObject>();
    protected List<SObject> trigList = new List<SObject>();
    
    /* this map can be used to store records for processing
     * after the raw trigger input has been filtered.   
     * */ 
    protected Map<Id, SObject> recordsToProcessMap = new Map<Id, SObject>();
    protected List<SObject> recordsToProcessList = new List<SObject>();
    protected List<Id> recordIdsToProcessList = new List<Id>();
    
    
     /* for every class the first thing that
      * should be overriden is this method.  this
      * determines whether the class runs
      * and filters the records passed for 
      * logic to by applied.  This has no parameters.
      * Constructors should be overriden to pass params.
      * */
     protected abstract void filterRecords();
         
     /* this method should be used to do the logic 
      * for every class.  before this is called,
      * records must be filtered by whatever criteria
      * is necessary in order to reduce the batch size 
      * */
     protected abstract void execute();
 }