# Trigger Framework

This is a simple trigger framework for Apex development.

## Trigger Example


```apex
trigger CaseTrigger on Case (before update, before insert, after update, after insert) {
    VirtualTrigger dispatcher = new VirtualTrigger();

    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            dispatcher.addOperation(new SomeHelper(Trigger.new))
                .addOperation(new SomeOtherHelperTH(Trigger.new));
        }
        if(Trigger.isUpdate) {
            dispatcher.addOperation(new SomeHelper(Trigger.oldMap, Trigger.newMap));
        }
    }
    
    if(Trigger.isafter) {
        if(Trigger.isInsert) {
            dispatcher.addOperation(new SomeOtherHelper(Trigger.newMap));
        }
        if(Trigger.isUpdate) {
            dispatcher.addOperation(new SomeHelper(Trigger.oldMap, Trigger.newMap))
                .addOperation(new SomeOtherHelper(Trigger.oldMap, Trigger.newMap))
                .addOperation(new SomeHelper(Trigger.oldMap, Trigger.newMap));
        }
    }
   
    dispatcher.dispatch();
}
```

## Trigger Helper Example

```apex
public with sharing class SomeHelperTH extends AbstractTrigger {

	public SomeHelperTH(List<SObject> newTrig) {
        this.context = TriggerContext.AFTERINSERT;

        this.trigList = newTrig;
    }

    public SomeHelperTH(Map<Id, SObject> oldTrig, Map<Id, Asset> newTrig) {
        this.context = TriggerContext.BEFOREUPDATE;
        
        this.oldTrig = oldTrig;
        this.newTrig = newTrig;
    }


    override
    public void filterRecords() {}

	override
	public void execute() {}
}
```
