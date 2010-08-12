/*
 * Copyright (c) 2005-2010 Grameen Foundation USA
 *  All rights reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 *  implied. See the License for the specific language governing
 *  permissions and limitations under the License.
 *
 *  See also http://www.apache.org/licenses/LICENSE-2.0.html for an
 *  explanation of the license and how it is applied.
 */

package org.mifos.platform.questionnaire.domain;

import org.mifos.framework.exceptions.SystemException;
import org.mifos.platform.questionnaire.QuestionnaireConstants;
import org.mifos.platform.questionnaire.mappers.QuestionnaireMapper;
import org.mifos.platform.questionnaire.persistence.EventSourceDao;
import org.mifos.platform.questionnaire.persistence.QuestionDao;
import org.mifos.platform.questionnaire.persistence.QuestionGroupDao;
import org.mifos.platform.questionnaire.persistence.QuestionGroupInstanceDao;
import org.mifos.platform.questionnaire.service.EventSource;
import org.mifos.platform.questionnaire.service.QuestionDetail;
import org.mifos.platform.questionnaire.service.QuestionGroupDetail;
import org.mifos.platform.questionnaire.service.QuestionGroupDetails;
import org.mifos.platform.questionnaire.service.QuestionGroupInstanceDetail;
import org.mifos.platform.questionnaire.service.SectionDetail;
import org.mifos.platform.questionnaire.service.SectionQuestionDetail;
import org.mifos.platform.questionnaire.validators.QuestionnaireValidator;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

import static org.mifos.platform.util.CollectionUtils.isNotEmpty;

public class QuestionnaireServiceImpl implements QuestionnaireService {

    @Autowired
    private QuestionnaireValidator questionnaireValidator;

    @Autowired
    private QuestionDao questionDao;

    @Autowired
    private QuestionGroupDao questionGroupDao;

    @Autowired
    private EventSourceDao eventSourceDao;

    @Autowired
    private QuestionGroupInstanceDao questionGroupInstanceDao;

    @Autowired
    private QuestionnaireMapper questionnaireMapper;

    @SuppressWarnings({"UnusedDeclaration"})
    private QuestionnaireServiceImpl() {
    }

    public QuestionnaireServiceImpl(QuestionnaireValidator questionnaireValidator, QuestionDao questionDao,
                                    QuestionnaireMapper questionnaireMapper, QuestionGroupDao questionGroupDao,
                                    EventSourceDao eventSourceDao, QuestionGroupInstanceDao questionGroupInstanceDao) {
        this.questionnaireValidator = questionnaireValidator;
        this.questionDao = questionDao;
        this.questionnaireMapper = questionnaireMapper;
        this.questionGroupDao = questionGroupDao;
        this.eventSourceDao = eventSourceDao;
        this.questionGroupInstanceDao = questionGroupInstanceDao;
    }

    @Override
    public QuestionDetail defineQuestion(QuestionDetail questionDetail) throws SystemException {
        questionnaireValidator.validateForDefineQuestion(questionDetail);
        QuestionEntity question = questionnaireMapper.mapToQuestion(questionDetail);
        persistQuestion(question);
        return questionnaireMapper.mapToQuestionDetail(question);
    }

    @Override
    public List<QuestionDetail> getAllQuestions() {
        List<QuestionEntity> questions = questionDao.retrieveByState(QuestionState.ACTIVE.getValue());
        return questionnaireMapper.mapToQuestionDetails(questions);
    }

    @Override
    public QuestionGroupDetail defineQuestionGroup(QuestionGroupDetail questionGroupDetail) throws SystemException {
        questionnaireValidator.validateForDefineQuestionGroup(questionGroupDetail);
        QuestionGroup questionGroup = questionnaireMapper.mapToQuestionGroup(questionGroupDetail);
        questionGroupDao.create(questionGroup);
        return questionnaireMapper.mapToQuestionGroupDetail(questionGroup);
    }

    @Override
    public List<QuestionGroupDetail> getAllQuestionGroups() {
        List<QuestionGroup> questionGroups = questionGroupDao.getDetailsAll();
        return questionnaireMapper.mapToQuestionGroupDetails(questionGroups);
    }

    @Override
    public boolean isDuplicateQuestionTitle(String title) {
        List result = questionDao.retrieveCountOfQuestionsWithTitle(title);
        return (Long) result.get(0) > 0;
    }

    @Override
    public QuestionGroupDetail getQuestionGroup(int questionGroupId) throws SystemException {
        QuestionGroup questionGroup = questionGroupDao.getDetails(questionGroupId);
        if (questionGroup == null) {
            throw new SystemException(QuestionnaireConstants.QUESTION_GROUP_NOT_FOUND);
        }
        return questionnaireMapper.mapToQuestionGroupDetail(questionGroup);
    }

    @Override
    public QuestionDetail getQuestion(int questionId) throws SystemException {
        QuestionEntity question = questionDao.getDetails(questionId);
        if (question == null) {
            throw new SystemException(QuestionnaireConstants.QUESTION_NOT_FOUND);
        }
        return questionnaireMapper.mapToQuestionDetail(question);
    }

    @Override
    public List<EventSource> getAllEventSources() {
        return questionnaireMapper.mapToEventSources(eventSourceDao.getDetailsAll());
    }

    @Override
    public List<QuestionGroupDetail> getQuestionGroups(Integer entityId, EventSource eventSource) throws SystemException {
        questionnaireValidator.validateForEventSource(eventSource);
        List<QuestionGroup> questionGroups = questionGroupDao.retrieveQuestionGroupsByEventSource(eventSource.getEvent(), eventSource.getSource());
        return getQuestionGroupDetailsAndResponses(entityId, questionGroups);
    }

    @Override
    public void saveResponses(QuestionGroupDetails questionGroupDetails) {
        questionnaireValidator.validateForQuestionGroupResponses(questionGroupDetails.getDetails());
        questionGroupInstanceDao.saveOrUpdateAll(questionnaireMapper.mapToQuestionGroupInstances(questionGroupDetails));
    }

    @Override
    public void validateResponses(List<QuestionGroupDetail> questionGroupDetails) {
        questionnaireValidator.validateForQuestionGroupResponses(questionGroupDetails);
    }

    @Override
    public List<QuestionGroupInstanceDetail> getQuestionGroupInstances(Integer entityId, EventSource eventSource, Boolean includeUnansweredQuestionGroups, boolean fetchLastVersion) {
        questionnaireValidator.validateForEventSource(eventSource);
        Integer eventSourceId = getEventSourceEntity(eventSource).getId();
        List questionGroupInstances = null;
        if(fetchLastVersion){
            questionGroupInstances = questionGroupInstanceDao.retrieveLatestQuestionGroupInstancesByEntityIdAndEventSourceId(entityId, eventSourceId);
        }else{
            questionGroupInstances = questionGroupInstanceDao.retrieveQuestionGroupInstancesByEntityIdAndEventSourceId(entityId, eventSourceId);
        }
        List<QuestionGroupInstanceDetail> questionGroupInstanceDetails = questionnaireMapper.mapToQuestionGroupInstanceDetails(questionGroupInstances);
        if (includeUnansweredQuestionGroups) {
            List<QuestionGroup> questionGroups = questionGroupDao.retrieveQuestionGroupsByEventSource(eventSource.getEvent(), eventSource.getSource());
            questionGroupInstanceDetails = mergeUnansweredQuestionGroups(questionGroupInstanceDetails, questionGroups);
        }
        return questionGroupInstanceDetails;
    }

    private List<QuestionGroupInstanceDetail> mergeUnansweredQuestionGroups(List<QuestionGroupInstanceDetail> instancesWithResponses, List<QuestionGroup> questionGroups) {
        List<QuestionGroupInstanceDetail> allInstances = new ArrayList<QuestionGroupInstanceDetail>(instancesWithResponses);
        for (QuestionGroup questionGroup : questionGroups) {
            if (!hasResponse(questionGroup, instancesWithResponses)) {
                allInstances.add(questionnaireMapper.mapToEmptyQuestionGroupInstanceDetail(questionGroup));
            }
        }
        return allInstances;
    }

    private boolean hasResponse(QuestionGroup questionGroup, List<QuestionGroupInstanceDetail> questionGroupInstances) {
        boolean result = false;
        for (QuestionGroupInstanceDetail questionGroupInstance : questionGroupInstances) {
            if (questionGroupInstance.getQuestionGroupDetail().getId() == questionGroup.getId()) {
                result = true;
                break;
            }
        }
        return result;
    }

    @Override
    public QuestionGroupInstanceDetail getQuestionGroupInstance(int questionGroupInstanceId) {
        QuestionGroupInstance questionGroupInstance = questionGroupInstanceDao.getDetails(questionGroupInstanceId);
        return questionnaireMapper.mapToQuestionGroupInstanceDetail(questionGroupInstance);
    }

    private List<QuestionGroupDetail> getQuestionGroupDetailsAndResponses(Integer entityId, List<QuestionGroup> questionGroups) {
        List<QuestionGroupDetail> questionGroupDetails = questionnaireMapper.mapToQuestionGroupDetails(questionGroups);
        if (entityId != null) {
            for (int i = 0, questionGroupsSize = questionGroups.size(); i < questionGroupsSize; i++) {
                QuestionGroup questionGroup = questionGroups.get(i);
                List list = questionGroupInstanceDao.retrieveLatestQuestionGroupInstanceByQuestionGroupAndEntity(entityId, questionGroup.getId());
                if (isNotEmpty(list)) {
                    QuestionGroupInstance questionGroupInstance = (QuestionGroupInstance) list.get(0);
                    setResponseOnSectionDetails(questionGroupInstance.getQuestionGroupResponses(), questionGroupDetails.get(i));
                }
            }
        }
        return questionGroupDetails;
    }

    private void setResponseOnSectionDetails(List<QuestionGroupResponse> questionGroupResponses, QuestionGroupDetail questionGroupDetail) {
        if (isNotEmpty(questionGroupResponses)) {
            for (SectionDetail sectionDetail : questionGroupDetail.getSectionDetails()) {
                setResponseOnSectionDetail(questionGroupResponses, sectionDetail);
            }
        }
    }

    private void setResponseOnSectionDetail(List<QuestionGroupResponse> questionGroupResponses, SectionDetail sectionDetail) {
        for (SectionQuestionDetail sectionQuestionDetail : sectionDetail.getQuestions()) {
            questionnaireMapper.mapQuestionResponse(sectionQuestionDetail, questionGroupResponses);
        }
    }

    private EventSourceEntity getEventSourceEntity(EventSource eventSource) {
        return (EventSourceEntity) eventSourceDao.retrieveByEventAndSource(eventSource.getEvent(), eventSource.getSource()).get(0);
    }

    private void persistQuestion(QuestionEntity question) throws SystemException {
        try {
            questionDao.saveOrUpdate(question);
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            throw new SystemException(QuestionnaireConstants.DUPLICATE_QUESTION, e);
        }
    }

}
