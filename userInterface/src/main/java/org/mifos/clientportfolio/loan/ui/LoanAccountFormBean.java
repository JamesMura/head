/*
 * Copyright (c) 2005-2011 Grameen Foundation USA
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 * See also http://www.apache.org/licenses/LICENSE-2.0.html for an
 * explanation of the license and how it is applied.
 */

package org.mifos.clientportfolio.loan.ui;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import org.mifos.platform.validation.MifosBeanValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.binding.message.MessageBuilder;
import org.springframework.binding.message.MessageContext;
import org.springframework.binding.validation.ValidationContext;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

@SuppressWarnings("PMD")
@edu.umd.cs.findbugs.annotations.SuppressWarnings(value={"SE_NO_SERIALVERSIONID", "EI_EXPOSE_REP", "EI_EXPOSE_REP2"}, justification="should disable at filter level and also for pmd - not important for us")
public class LoanAccountFormBean implements Serializable {

    @Autowired
    private transient MifosBeanValidator validator;
    private transient DateValidator dateValidator;

    @NotNull
    private Integer productId;

    // custom validation
    private Number amount;
    private Number minAllowedAmount;
    private Number maxAllowedAmount;
    private Number interestRate;
    private Number minAllowedInterestRate;
    private Number maxAllowedInterestRate;
    private Number numberOfInstallments;
    private Number minNumberOfInstallments;
    private Number maxNumberOfInstallments;
    private Number disbursalDateDay;
    private Number disbursalDateMonth;
    private Number disbursalDateYear;
    
    private Number graceDuration = Integer.valueOf(0);
    
    private Integer fundId;
    private Integer loanPurposeId;
    private Integer collateralTypeId;
    private String collateralNotes;
    private String externalId;
    
    private String[] selectedFeeId;
    private String[] selectedFeeAmount;
    
    public void validateEnterAccountDetailsStep(ValidationContext context) {
        MessageContext messages = context.getMessageContext();
        Errors errors = validator.checkConstraints(this);
        
        if (this.amount == null || exceedsMinOrMax(this.amount, this.minAllowedAmount, this.maxAllowedAmount)) {
            errors.rejectValue("amount", "loanAccountFormBean.Amount.invalid", new Object[] {this.minAllowedAmount, this.maxAllowedAmount}, "Please specify valid Amount.");
        }
        
        if (this.interestRate == null || exceedsMinOrMax(this.interestRate, this.minAllowedInterestRate, this.maxAllowedInterestRate)) {
            errors.rejectValue("interestRate", "loanAccountFormBean.InterestRate.invalid", new Object[] {this.minAllowedInterestRate, this.maxAllowedInterestRate}, "Please specify valid Interest rate.");
        }
        
        if (this.numberOfInstallments == null || exceedsMinOrMax(this.numberOfInstallments, this.minNumberOfInstallments, this.maxNumberOfInstallments)) {
            errors.rejectValue("numberOfInstallments", "loanAccountFormBean.NumberOfInstallments.invalid", new Object[] {this.minNumberOfInstallments, this.maxNumberOfInstallments}, "Please specify valid number of installments.");
        }

        dateValidator = new DateValidator();
        if (!dateValidator.formsValidDate(this.disbursalDateDay, this.disbursalDateMonth, this.disbursalDateYear)) {
            errors.rejectValue("disbursalDateDay", "loanAccountFormBean.DisbursalDate.invalid", "Please specify valid disbursal date.");
        }
        
        if (errors.hasErrors()) {
            for (FieldError fieldError : errors.getFieldErrors()) {
                MessageBuilder builder = new MessageBuilder().error().source(fieldError.getField())
                                                      .codes(fieldError.getCodes())
                                                      .defaultText(fieldError.getDefaultMessage()).args(fieldError.getArguments());
                
                messages.addMessage(builder.build());
            }
        }
    }

    private boolean exceedsMinOrMax(Number defaultValue, Number minValue, Number maxValue) {
        return defaultValue.doubleValue() > maxValue.doubleValue() || defaultValue.doubleValue() < minValue.doubleValue();
    }

    public String[] getSelectedFeeId() {
		return selectedFeeId;
	}

	public void setSelectedFeeId(String[] selectedFeeId) {
		this.selectedFeeId = selectedFeeId;
	}

	public String[] getSelectedFeeAmount() {
		return selectedFeeAmount;
	}

	public void setSelectedFeeAmount(String[] selectedFeeAmount) {
		this.selectedFeeAmount = selectedFeeAmount;
	}

	public String getExternalId() {
		return externalId;
	}

	public void setExternalId(String externalId) {
		this.externalId = externalId;
	}

	public String getCollateralNotes() {
		return collateralNotes;
	}

	public void setCollateralNotes(String collateralNotes) {
		this.collateralNotes = collateralNotes;
	}

	public Integer getLoanPurposeId() {
		return loanPurposeId;
	}

	public void setLoanPurposeId(Integer loanPurposeId) {
		this.loanPurposeId = loanPurposeId;
	}

	public Integer getCollateralTypeId() {
		return collateralTypeId;
	}

	public void setCollateralTypeId(Integer collateralTypeId) {
		this.collateralTypeId = collateralTypeId;
	}

	public Integer getFundId() {
		return fundId;
	}

	public void setFundId(Integer fundId) {
		this.fundId = fundId;
	}

	public Number getGraceDuration() {
		return graceDuration;
	}

	public void setGraceDuration(Number graceDuration) {
		this.graceDuration = graceDuration;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Number getAmount() {
		return amount;
	}

	public void setAmount(Number amount) {
		this.amount = amount;
	}

	public Number getInterestRate() {
		return interestRate;
	}

	public void setInterestRate(Number interestRate) {
		this.interestRate = interestRate;
	}

	public Number getNumberOfInstallments() {
		return numberOfInstallments;
	}

	public void setNumberOfInstallments(Number numberOfInstallments) {
		this.numberOfInstallments = numberOfInstallments;
	}

	public Number getDisbursalDateDay() {
		return disbursalDateDay;
	}

	public void setDisbursalDateDay(Number disbursalDateDay) {
		this.disbursalDateDay = disbursalDateDay;
	}

	public Number getDisbursalDateMonth() {
		return disbursalDateMonth;
	}

	public void setDisbursalDateMonth(Number disbursalDateMonth) {
		this.disbursalDateMonth = disbursalDateMonth;
	}

	public Number getDisbursalDateYear() {
		return disbursalDateYear;
	}

	public void setDisbursalDateYear(Number disbursalDateYear) {
		this.disbursalDateYear = disbursalDateYear;
	}
	
    public Number getMinAllowedAmount() {
        return minAllowedAmount;
    }

    public void setMinAllowedAmount(Number minAllowedAmount) {
        this.minAllowedAmount = minAllowedAmount;
    }

    public Number getMaxAllowedAmount() {
        return maxAllowedAmount;
    }

    public void setMaxAllowedAmount(Number maxAllowedAmount) {
        this.maxAllowedAmount = maxAllowedAmount;
    }
    
    public Number getMinAllowedInterestRate() {
        return minAllowedInterestRate;
    }

    public void setMinAllowedInterestRate(Number minAllowedInterestRate) {
        this.minAllowedInterestRate = minAllowedInterestRate;
    }

    public Number getMaxAllowedInterestRate() {
        return maxAllowedInterestRate;
    }

    public void setMaxAllowedInterestRate(Number maxAllowedInterestRate) {
        this.maxAllowedInterestRate = maxAllowedInterestRate;
    }

    public Number getMinNumberOfInstallments() {
        return minNumberOfInstallments;
    }

    public void setMinNumberOfInstallments(Number minNumberOfInstallments) {
        this.minNumberOfInstallments = minNumberOfInstallments;
    }

    public Number getMaxNumberOfInstallments() {
        return maxNumberOfInstallments;
    }

    public void setMaxNumberOfInstallments(Number maxNumberOfInstallments) {
        this.maxNumberOfInstallments = maxNumberOfInstallments;
    }
}