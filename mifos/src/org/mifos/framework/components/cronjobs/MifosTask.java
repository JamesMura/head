/**

 * MifosTask.java    version: 1.0



 * Copyright (c) 2005-2006 Grameen Foundation USA

 * 1029 Vermont Avenue, NW, Suite 400, Washington DC 20005

 * All rights reserved.



 * Apache License
 * Copyright (c) 2005-2006 Grameen Foundation USA
 *

 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License. You may obtain
 * a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 *

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and limitations under the

 * License.
 *
 * See also http://www.apache.org/licenses/LICENSE-2.0.html for an explanation of the license

 * and how it is applied.

 *

 */

package org.mifos.framework.components.cronjobs;

import java.util.TimerTask;

/**
 * @author krishankg
 *
 */
public class MifosTask extends TimerTask {


	public TaskHelper helper;

	/**
	 * Name of the task same as specified in XML
	 */
	public String name;

	/**
	 * Attribute which determines if the job is a
	 * regular DB update job to be run daily and hence
	 * registereed in the database or a user requested
	 * job. [ if true : job should run daily false :
	 * user requested job ]
	 */
	public boolean normal;

	/**
	 * An alternate set of parameters which could be set
	 * while the task is created.This constitutes input
	 * to the MifosTask while executing.
	 */
	public Object params;


	public MifosTask() {
	}

	public void run() {
	}

	public boolean cancel() {
		return true;
	}

}
