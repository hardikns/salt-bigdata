#!/usr/bin/env python
import logging
log = logging.getLogger(__name__)

setup = {
    'salt-demo-1': ['webserver'],
    'salt-demo-2': ['db-server'],
    'salt-demo-3': ['db-server'],
    'salt-demo-4': ['webserver'],
    'salt-demo-5': ['webserver'],        
}

def function():
    minion_id = __opts__.get('id',"Notfound")
    log.trace('Setting grains["spam"] to "eggs"')
    grains = {}
    grains['custom_roles'] = setup.get(minion_id, [])
    return grains