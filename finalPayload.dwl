%dw 2.0
output application/xml
var packageResp = vars.packageResp
var opportunityResp = vars.opportunityResp
---
{
    fja:
    {
        transaction: {
            datamodel: "fja",
            metadata: {
            	documentSubclass: "CEM-SummaryOfBenefit",
            	opportunityId: opportunityResp.opportunityId,
            	packageId: packageResp.packageId,
            	requestId: uuid()
            },
            document: {
                templateName: "Benefit Summary Report",
                templateID: 159124182,
                transactGUID: "9a42aec4-0b17-49dc-894b-4adfb986651e",
                subjectArea: "sender",
                subjectArea:"recipients",
                subjectArea: "summaryOfBenefits"
            },
            sender: {
                general:{
                    firstName: "Roger",
                    middleName: "",
                    lastName: "Federrer",
                    prefix: "",
                    designation: "Ph.D",
                    suffix: "Sr",
                    jobTitle: "Architect"

                },
                contact: {
                    address: {
                        addressL1: ">4521 Village Springs Run",
                        addressL2: "",
                        addressL3: "",
                        city: "NewYork",
                        state: "NY",
                        zipCode: 50338,
                        country: "US",
                        countryCode: 111
                    },
                    email: {
                        "type": "Unknown",
                        emailAddress: "-"
                    },
                    phone: {
                        "type": "Personal",
                        intCode: "+11",
                        areaCode: "00",
                        phoneNumber: 456789

                    }                 
                },
                underwritingCompany: {
                    underwritingCompanyName: "Life Insurance Company of North America"
                }

            },
            recipients: {
                primaryRecipient:{
                    general: {
                        firstName: "Lamar",
                        middleName: "",
                        lastName: "Simmons",
                        prefix: "",
                        designation: "Ph.D",
                        suffix: "Jr",
                        jobTitle: "Architect"
                    },
                    "type": "Primary",
                    companyName: "PFL Test",
                    contact: {
                        address: {
                            addressL1: ">4521 Village Springs Run",
                            addressL2: "",
                            addressL3: "",
                            city: "Atlanta",
                            state: "GA",
                            zipCode: 30338,
                            country: "US",
                            countryCode: 111

                        },
                        email: {
                            "type": "Unknown",
                            emailAddress: "-"
                        },
                        phone: {
                        "type": "Personal",
                        intCode: "+11",
                        areaCode: "00",
                        phoneNumber: 123456
                    }
                    },
                    channels:
                    {
                        localPrint: false,
                        postal: false,
                        email: true,
                        secureEmail: false,
                        fax: false
                    }
                }

            },
            summaryOfBenefits: {
                lineOfBusiness: packageResp.Plan map ((planItem , pindex) -> {
                    productCode: planItem.productType,
                    logo: null default "-",
                    rates: {
                        eeSplitContributionType: null default "None",

                    },
                    rateModal: {
                        splitContributionType:  null default "None for all included coverages",
                        eeSplitContributionType: null default 10
                    },
                    "case": {
                            accountName: null default "Hays Companies"
                    },
                    eligibleClass: planItem.EligibilityClass map (eligibilityClsItem , eindex) -> {
                        locationName: eligibilityClsItem.LocationName,
                        className: eligibilityClsItem.eligibilityClassName,
                        classDescription: eligibilityClsItem.eligibilityClassDescription,
                        //eligibilityWaitingPeriod: eligibilityClsItem.EligibilityWaitingPeriod,
                        //eligibilityWaitingPeriodDays: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodDays,
                        //eligibilityWaitingPeriodMonths: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodMonths,
                        //eligibilityWaitingPeriodOther: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodOther,
				    	planDesign: eligibilityClsItem.PlanDesign map (pdItem , eindex) ->
				    		{
						        eligibilityWaitingPeriod: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriod as String default "After X Days",
						        eligibilityWaitingPeriodDays: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodDays as String default null,
						        eligibilityWaitingPeriodMonths: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodMonths as String default "30",
						        eligibilityWaitingPeriodOther: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodOther as String default "other" ,
						        depedentCoverage: null default "Spouse or Family",
						        dependentEligibility: pdItem.DependentEligibilit as String default "Child or Family",				      
						        domesticPartnerEligible: pdItem.DomesticPartnerEligible as String default "YES",
						        spouseEligibleWithoutEE: pdItem.Coverage[0].SpouseEligibleWoutEEEnrollment as String default "NO",
						        dependentChildEligibleWithoutEE: pdItem.Coverage[0].DependentChildEligibleWOutEEEnrollment as String default "NO",
						        extendedDeathBenefit: pdItem.WaiverOfPremium.ExtendedDeathBenefit.ExtendedDeathBenefit default true,
						        extendedDeathBenefitMaximumDuration : pdItem.ExtendedDeathBenefit.ExtendedDeathBenefitMaximumDuration default "CR",
						        waiverOfPremiumDurationAge: pdItem.WaiverOfPremium.WaiverOfPremiumDurationAge as String default '65',
						        extendedDeathBenefitDisabledBeforeAge: null default "CR",
						        continuationOfDisabilityDuration: pdItem.WaiverOfPremium.ContinuationOfDisabilityStartingAge as String default '65',
						        waiverOfPremiumDisabledBeforeAge: pdItem.WaiverOfPremium.WaiverOfPremiumUpToAge as String default '40',
						        waiverOfPremiumWaitingPeriod: pdItem.WaiverOfPremium.WaiverOfPremiumWaitingPeriod as String default '9',
						        employeeContributionType: null default null,
						        flatDollarAmount: pdItem.Coverage[0].flatAmt as String default null, // $ is removed , revisit mapping
						        waiverOfPremium: pdItem.WaiverOfPremium.WaiverOfPremium as String default null,
						        continuationOfDisability: pdItem.ContinuationOfDisabilityas as String default null,
						        matchLifeBenefit: null default null,
						        coverageEndAtAge: null default null,
						        coverageEndAtAgeForFullTimeStudent: null default null,
						        coverageEndAtAgeForNotFullTimeStudent: null default null,
			        			coverage:  
			        				{
									  	benefitType:  pdItem.Coverage map(covItem , i) ->{
							            //coverage: eligibilityClsItem.PlanDesign[0].Coverage,
							            coverageType: covItem.coverageType as String default null,
							            splitContributionType: null default "None for all included coverages",
							            eeSplitContributionType: covItem.EEContributions default "None",
							            adAndDRider: covItem.ADDRider default "NO",
							            //adAndDRiderBenefitPercentage: "",
							            //adAndDRiderType: "",
							            LifeCoverageEndsAtAge: covItem.BenefitType.LifeCoverageEndsAtAge default "18",
							            childBenfitBirthTo14Days: covItem.BenefitType.BirthTo14DaysOld default "1000",
							            childBenfit14DaysTo6Month: covItem.BenefitType.Days14To6MonthsOld default "1000",
							            coverageEndAtAgeForFullTimeStudent: null default "1000",
							            coverageEndAtAgeForNotFullTimeStudent: null default "1000",
							            benefitType: covItem.BenefitType default "Times Salary",
							            flatBenefitAmount:{
							            	flatBenefitAmount1:covItem.BenefitType.FlatBenefitAmount1,
							            	flatBenefitAmount2:covItem.BenefitType.FlatBenefitAmount2,
							            	flatBenefitAmount3:covItem.BenefitType.FlatBenefitAmount3,
							            	flatBenefitAmount4:covItem.BenefitType.FlatBenefitAmount4,
							            	flatBenefitAmount5:covItem.BenefitType.FlatBenefitAmount5,
							            	flatBenefitAmount6:covItem.BenefitType.FlatBenefitAmount6,
							            	flatBenefitAmount7:covItem.BenefitType.FlatBenefitAmount7,
							            	flatBenefitAmount8:covItem.BenefitType.FlatBenefitAmount8,
							            	flatBenefitAmount9:covItem.BenefitType.FlatBenefitAmount9,
							            	flatBenefitAmount10:covItem.BenefitType.FlatBenefitAmount10
							      
							            } ,
							            unitsOf: covItem.UnitsOf default "5",
							            eeUnitsOf: null default "5",
							            childUnitsOf: "",
							            spouseUnitsOf: "",
							            salaryMultiple:{
							            	salaryMultiple1:covItem.BenefitType.SalaryMultiple1,
							            	salaryMultiple2:covItem.BenefitType.SalaryMultiple2,
							            	salaryMultiple3:covItem.BenefitType.SalaryMultiple3,
							            	salaryMultiple4:covItem.BenefitType.SalaryMultiple4,
							            	salaryMultiple5:covItem.BenefitType.SalaryMultiple5,
							            	salaryMultiple6:covItem.BenefitType.SalaryMultiple6,
							            	salaryMultiple7:covItem.BenefitType.SalaryMultiple7,
							            	salaryMultiple8:covItem.BenefitType.SalaryMultiple8,
							            	salaryMultiple9:covItem.BenefitType.SalaryMultiple9,
							            	salaryMultiple10:covItem.BenefitType.SalaryMultiple10
							            },
							            earningType: covItem.BenefitType.EarningsType default "salary",
							            benefitMinimum: covItem.BenefitType.BenefitMinimum default "500",
							            benefitMaximum: covItem.BenefitType.BenefitMaximumPct default "1000",
							            guarateedIssueAmount: covItem.BenefitType.GuaranteedIssueAmount default "1000",
							            guarateedIssueTimesSalary: covItem.BenefitType.GuaranteedIssueTimesSalary default "1000",
							            //coverageEndAtAgeForNotFullTimeStudent: "",
							            typeOfAnnualEntrollmentIncrease: null default "Benefit Level Increase",
							            unitsOfIncrease: null default "10",
							            percentageOfBenefit: null default "15",
							            percentageBasis: covItem.BenefitType.PercentageBasis default "15",
							            benefitReductionSchedule: covItem.AgeReductions.BenefitReductionSchedule default "30",
							            spouseReductionAgeBasis: null default "65",
							            AcceleratedDeathBenefit: "" default null,
							            spouseAcceleratedDeathBenefit: covItem.AcceleratedDeathBenefit.SpouseAcceleratedDeathBenefit default "100",
							            upToPercentage: covItem.AcceleratedDeathBenefit.SpouseAcceleratedDeathBenefit.UpToPctSgn default "20",
							            dependentEligibility: eligibilityClsItem.PlanDesign[0].DependentEligibility default "Spouse or Family",
							            extendedDeathBenefit: eligibilityClsItem.PlanDesign[0].ExtendedDeathBenefit.ExtendedDeathBenefit default "true",
							            adAndDRiderType: null default "NO",
							            adAndDRiderBenefitPercentage: null default "15",
							            //seatbelt: null default "",
							            commonCarrier: null default "YES",
							            commonCarrierPercentage: null default "10",
							            commonCarrierMaximum: null default "10000",
							            feloniousAssault: null default "YES",
							            feloniousAssaultMaximum: null default "10",
							            feloniousAssaultPercentage: null default "1000",
							            seatbeltBenefitPercentage: null default "10",
							            seatbeltBenefitMaximum: null default "1500",
							            seatbeltFlatAmount: null default "30000",
							            combinedTimesSalary: null default "30000",
							            combinedBenefitMaximum: null default "3000",
							            employeeBenefitType: "",
							            employeeTypeOfAnnualEnrollmentIncrease: covItem.BenefitType.TypeOfAnnualEnrollmentIncrease,
							            employeeUnitsIncrease: "",
							            spouseBenefitType: "",
							            spouseTypeOfAnnualEnrollmentIncrease: "",
							            spouseUnitsIncrease: "",
							            benefitLevelIncrease: "",
							            eeBenefitType: "",
							            eeTypeOfAnnualEnrollmentIncrease: "",
							            eeBenefitLevelIncrease: "",
							            spouseBenefitLevelIncrease: "",
							            flatAmount: "", //revisit mapping
							            employeeAcceleratedDeathBenefit: "",
							            percentage: "",
							            percentageContribution: "",
							            spouseCompositeRate: "",
							            childContributionPercentage: "",
							            employeeCompositeRate: "",
							            commonCarrierFlatAmount: "",
							            feloniousAssaultFlatAmount: "",
							            //acceleratedDeathBenefit: covItem.AcceleratedDeathBenefit,
							            //coverageEndAtAgeForFullTimeStudent: covItem.BenefitType.FullTimeStudents,
							            //airbagBenefitPercentage: "",
							            //airbagFlat: "",
							            //childAccidentalInjuryFlat: "",
							            //childDayCareBenefitPercentage: "",
							            //childDayCareFlat: "",
							            //comaBenefitPercentage: "",
							            //commonCarrierBenefitPercentage: "",
							            //commonCarrierFlat: "",
							            //commonDualAccidentalBenefit: "",
							            //commonDualAccidentalFlat: "",
							            //dependentChildEligibleWithoutEE: "",
							            //employeeRateBasis: "",
							            //exposureAndDisapperance: "",
							            //feloniousAssaultBenefitPercentage: "",
							            //feloniousAssaultFlat: "",
							            //matchLifeBenefit: "",
							           //rehabilitationBenefitPercentage: "",
							            //rehabilitationFlat: "",
							            //roundingRule: "",
							            //SEB1AdditionalBenefitPercentage: "",
							            //SEB2AdditionalBenefitPercentage: "",
							            //SEB3ChildAdditionalBenefitPercentage: "",
							            //spUnitsOf: "",
							            //spouseEligibleWithoutEEEnrollment: "",
							            //spouseRetrainingBenefitPercentage: "",
							            //spouseRetrainingFlat: "",
							            //survivingSpouseBenefitPercentage: "",
							            //survivingSpouseFlat: "",
										//}
										rounding:
			         					{
								            roundingRule: covItem.BenefitType.RoundingRule default "Nearest",
								            roundingAmount: covItem.BenefitType.RoundingAmount default "500",
								            roundingRuleAppliesTo: covItem.BenefitType.RoundingRuleAppliesTo default "Guaranteed issue"
								        }
				        			 },// End of BenefitType
							        
								    plan: 
								    	{
								            situsState: if(planItem.situsState != null) planItem.situsState else opportunityResp.CovPolicyNumber.CovPolicyNumberEntry[0].situsState,
											product: planItem.CovPolicyNumber.CovPolicyNumberEntry[0].PolicySymbol,
								            waiverOfPremiumDisabledBeforeAge: eligibilityClsItem.PlanDesign[0].WaiverOfPremium.WaiverOfPremiumUpToAge as String default "40",
								            waiverOfPremiumDuration: eligibilityClsItem.PlanDesign[0].WaiverOfPremium.WaiverOfPremiumDuration as String default "To Age" ,
								            waiverOfPremiumDurationAge: eligibilityClsItem.PlanDesign[0].WaiverOfPremium.WaiverOfPremiumDurationAge as String default "65",
								            waiverOfPremiumWaitingPeriod: eligibilityClsItem.PlanDesign[0].WaiverOfPremium.WaiverOfPremiumWaitingPeriod as String default "9",
								            creationDate: if(packageResp.createDate != null) packageResp.createDate else opportunityResp.createDate as String default "",
								            continuationOfDisabilityStartingAge: eligibilityClsItem.PlanDesign[0].WaiverOfPremium.ContinuationOfDisabilityStartingAge as String default "60",
								            continuationOfDisabilityDuration: eligibilityClsItem.PlanDesign[0].WaiverOfPremium.ContinuationOfDisabilityDuration as String default "75",
								            continuationOfDisabilityDurationMonths: eligibilityClsItem.PlanDesign[0].WaiverOfPremium.ContinuationOfDisabilityDurationMonths as String default "08",
								            extendedDeathBenefit: eligibilityClsItem.PlanDesign[0].ExtendedDeathBenefit[0].ExtendedDeathBenefit as String default "true",
								            portabilityEligibility: eligibilityClsItem.PlanDesign[0].ConversionAndPortability[0].PortabilityEligibility as String default "Employee",
								            portabilityDuration: eligibilityClsItem.PlanDesign[0].ConversionAndPortability.PortabilityDuration as String default "",
								            portabilityDurationAge: eligibilityClsItem.PlanDesign[0].ConversionAndPortability.portabilityDurationAge as String default "35",
								            portabilityDurationYears: eligibilityClsItem.PlanDesign[0].ConversionAndPortability.portabilityDurationYears as String default "10",
								            conversionNoOfDaysToApply: eligibilityClsItem.PlanDesign[0].ConversionAndPortability[0].ConversionNumberOfDaysToApply as String default "31",
											policyNumber: opportunityResp.CovPolicyNumber.CovPolicyNumberEntry[0].PolicyNumber,
											documentSubclass: null as String default "",
											documentGenerationDate: null as String default "01/01/2022",
											waiverOfPremium: eligibilityClsItem.PlanDesign[0].WaiverOfPremium.WaiverOfPremium as String default "",
											continuationOfDisability : eligibilityClsItem.PlanDesign[0].ContinuationOfDisability as String default "",
											//vaddPolicyNumber: "",
											//volLifePolicyNumber: "",
										},  // End of Plan
									rateStructure: 
										{
								            benefitType: eligibilityClsItem.PlanDesign[0].Coverage[0].BenefitType.BenefitType,
								            compositeRate: eligibilityClsItem.CompositeRateInd as String default  "1500",
								            spouseRateBasis: null as String default "20",            
								            ageBandApplies: eligibilityClsItem.PlanDesign[0].Coverage[0].RateStructureGroup.AgeBandApplies as String default "checked",
								            smokerStatusApplies: eligibilityClsItem.PlanDesign[0].Coverage[0].RateStructureGroup.SmokerStatusApplies as String default "unchecked",
											UnismokerRates: null as String default "",				
											payrollFrequency: opportunityResp.PayrollFrequency as String default "Monthly",
											pasteFromSpreadSheet: null as String default "NO",
											spouseContributionType: null as String default "None",
											spouseContributionPercentage: null as String default "None",
											contributionTypePercentage: null as String default "10",
											contributionTypeFlat: null as String default "Flat",
											childRateBasis: null as String default "",
											childContributionType: null as String default "",
											familyRateBasis: null as String default "",
											familyContributionType: null as String default "",
											employeeContributionType: null as String default "",
											employeeRateBasis: null as String default "",
											eeSmokerRates: null as String default "",
											eeNonSmokerRates: null as String default "",
											contributionType: null as String default "",
											percentage: null as String default "",
											percentageContribution: null as String default "",
											//spouseCompositeRate: "",
											//flatContribution: "",
											childContributionPercentage: null as String default "",
											familyCompositeRate: "",
											employeeContributionPercentage: null as String default "",
											familyContributionPercentage: null as String default "",
											employeeCompositeRate: null as String default "",
											//eeContributionType: "",
											//eechContributionType: "",
											//eespContributionType: "",
											//eechRateBasis: "",
											//eespRateBasis: "",
											//employeeContributionPercentage: "",
											//familyContributionPercentage: "",
							        	} // ***************End of Rate Structure *****************
				        }// ********************** End of Coverage ***********************
        	
        
			
        } // ************************ End of Plan Design ********************

}, // ************END OF ELIGIBLE CLASS *********************
       				add_covered_losses_modal: 
       				{
			        	addCoveredLosses: "",
			        	coveredLossBenefitPercentage: ""	
			        },
        			plan_summary: 
        			{
        				product: planItem.CovPolicyNumber.CovPolicyNumberEntry[0].Product
        	
        			},
        			copyRights: ""

    })
}
}}}       