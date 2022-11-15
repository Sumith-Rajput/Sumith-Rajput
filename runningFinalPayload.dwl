%dw 2.0
import * from dw::core::Strings
output application/xml
var packageResp = vars.packageResp
var opportunityResp = vars.opportunityResp
fun checkProduct(product: String) = 
	if(product == "Basic Term Life") "BTL" else  
	if(product == "Voluntary Term Life") "VTL" else "Not a Life Product(BTL/VTL)"

fun checkCoverageType(covType: String) = 
	if(covType == "Employee") "EE" else
	if(covType == "Spouse") "SPS" else 
	if(covType == "Child") "CH" else 
	if(covType == "Family") "FAM" else "Invalid Coverage Type"
	
	
fun checkSmoker(smokerType: String) = 
	if(smokerType == "Smoker")
		{
			first: "First Element",
			second: "Second element"
		}
	else
		{
			first: "First",
			second: "Non SMoker"
		}

---
{
    thunderhead:
    {
        transaction:
        {
        	document: 
        		{
	                templateName: "NYL FJA Master Document",
	                templateID: 159141617,
	                form: "",
	                brochure: "",
	                attachmentID: "",
	                inclReturnEnvelope: false,
	                defaultRecipientRole: "",
	                recipient: "",
	                ccRecipient: "",
	                isSTP: true,
	                xmlString: "",
	                transactGUID: vars.transactGuid,
	                benefitCaseId: "",
	                subjectArea: "sender",
	                subjectArea:"recipients",
	                subjectArea: "fja",
	                recipientType: "",
	                primaryRecipientindex: "",
	                ccRecipientindex: "",
	                isRCUtility: false,
	                senderId: "FJAStraightThrough",
	                //userId: "FJAStraightThrough",
	                corrDocType: "FJAEnrollmentMaterial",
	                triggerName: "FJA Report"
            	},
            notificationData: "",
            sender: 
            	{
	                general: 
	                	{
		                    firstName: "Roger",
		                    middleName: "",
		                    lastName: "Federrer",
		                    prefix: "",
		                    prefixNew: "",
		                    designation: "Ph.D",
		                    suffix: "Sr",
		                    jobTitle: "Architect"
	                	},
	                contact: 
	                	{
	                    	address: 
	                    		{
			                        addressL1: ">4521 Village Springs Run",
			                        addressL2: "",
			                        addressL3: "",
			                        city: "NewYork",
			                        state: "NY",
			                        zipCode: 50338,
			                        country: "US",
			                        countryCode: 111
	                    		},
	                    	email: 
	                    		{
	                        		"type": "Unknown",
	                        		emailAddress: "-"
	                    		},
	                    	fax: "",
	                    	phone: 
	                    		{
			                        "type": "Personal",
			                        intCode: "+11",
			                        areaCode: "00",
			                        phoneNumber: 456789,
			                        extension: "+11"
	                    		}                 
                		},
                	claimOffice:
	                	{
	                		address: 
		                		{
			                        addressL1: ">4521 Village Springs Run",
			                        addressL2: "",
			                        addressL3: "",
			                        city: "NewYork",
			                        state: "NY",
			                        zipCode: 50338,
			                        country: "US",
			                        countryCode: 111
		                    	},
	                    	phone: 
			                    {
			                        "type": "Personal",
			                        intCode: "+11",
			                        areaCode: "00",
			                        phoneNumber: 456789,
			                        extension: "+11"
			                    },
	                    	fax: ""
	                },
                	teamLeader: "",
                	vocationalResc: "",
	                underwritingCompany: 
	                	{
	                    	underwritingCompanyName: "Life Insurance Company of North America"
	                	}
            	},
            recipients: 
	            {
	                primaryRecipient: 
		                { 
		                    general:  
			                    {  
			                        firstName: "Lamar",
			                        middleName: "",
			                        lastName: "Simmons",
			                        prefix: "",
			                        designation: "Ph.D",
			                        suffix: "Jr",
			                        jobTitle: "Architect" 
			                    },
		                    ccAttachSelected: false,
		                    "type": "Primary",
		                    companyName: "PFL Test",
		                    contact: 
		                    	{ 
			                        address: 
			                        	{
				                            addressL1: ">4521 Village Springs Run",
				                            addressL2: "",
				                            addressL3: "",
				                            city: "Atlanta",
				                            state: "GA",
				                            zipCode: 30338,
				                            country: "US",
				                            countryCode: 111
			                        	},
		                        	email: 
				                        {
				                            "type": "Unknown",
				                            emailAddress: "-"
				                        },
		                        	fax: "",
		                        	phone: 
			                        	{
					                        "type": "Personal",
					                        intCode: "+11",
					                        areaCode: "00",
					                        phoneNumber: 123456,
					                        extension: 91
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
		                },
					ccRecipient: "",
					ccString: "",
					useSecureEmail: false,
					skipArchive: false
	            },            
            fja: 
            	{
           			metadata:
           				{
			            	documentSubclass: "FJAEnrollmentMaterial",
			            	opportunityId: opportunityResp.opportunityId,
			            	packageId: packageResp.packageId,
			            	fjaRequestId: vars.transactGuid,
			            	userId: "FJAStraightThrough"
			            },
			        assembledTransaction:
			        	{
			        		compositeTransaction: 
			        			{
			        				fjaDocument: 
			        					{
			        						templateName: "Benefit Summary Report",
			        						templateID: 159124182
			        					},
			        				summaryOfBenefits: 
			        					{
			        						lineOfBusiness: packageResp.Plan map ((planItem , pindex) -> {
			        							productCode: planItem.productType,
							                    rates: 
								                    {
								                        eeSplitContributionType: "", // NM
								                    },
								                rateModal: 
								                	{
								                        splitContributionType:  "", //NM
								                        eeSplitContributionType: "" //NM
                    								},
                    							"case": 
                    								{
                            							accountName: opportunityResp.Role[0].Name // NM 
                    								},
                    							plan: 
                    								{
								                    	situsState: if(planItem.situsState == null) opportunityResp.CovPolicyNumber.CovPolicyNumberEntry[0].situsState else planItem.situsState,
								                    	product: checkProduct(planItem.productType),
								                    	creationDate: if(packageResp.createDate == null) (opportunityResp.createDate as Number / 1000) as DateTime as String {format:"ddMMyyyy"} else (opportunityResp.createDate as Number / 1000) as DateTime as String {format:"ddMMyyyy"},
								                    	policyNumber: opportunityResp.CovPolicyNumber.CovPolicyNumberEntry[0].PolicySymbolAndNumber,
								                    	documentGenerationDate: "", //NM
								                    	vaddPolicyNumber: "", //NM
								                    	volLifePolicyNumber: "", //NM
								                    	productVTLPolicyNumber: "", //NM,
                    									eligibleClass: planItem.EligibilityClass map (eligibilityClsItem , eindex) -> {
								                        	locationName: eligibilityClsItem.LocationName,
								                        	className: eligibilityClsItem.eligibilityClassName,
								                        	classDescription: eligibilityClsItem.eligibilityClassDescription,
								                        	eligibilityWaitingPeriod: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriod,
								                        	eligibilityWaitingPeriodDays: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodDays,
								                        	eligibilityWaitingPeriodMonths: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodMonths,
								                        	eligibilityWaitingPeriodOther: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodOther,
												    		planDesign: eligibilityClsItem.PlanDesign map (pdItem , eindex) -> {												    				
												    			portabilityEligibility: pdItem.ConversionAndPortability.PortabilityEligibility as String,
								                    			portabilityDuration: pdItem.ConversionAndPortability.PortabilityDuration,
								                    			portabilityDurationAge: pdItem.ConversionAndPortability.PortabilityDurationAge,
								                    			portabilityDurationYears: pdItem.ConversionAndPortability.PortabilityDurationYears,
								                    			ConversionNumberOfDaysToApply: pdItem.ConversionAndPortability.ConversionNumberOfDaysToApply,
								                    			dependentCoverage: "", //NM
															    dependentEligibility: pdItem.DependentEligibility,				      
															    domesticPartnerEligible: pdItem.DomesticPartnerEligible ,
															    extendedDeathBenefit: pdItem.WaiverOfPremium.ExtendedDeathBenefit.ExtendedDeathBenefit,
															    extendedDeathBenefitMaximumDuration: pdItem.WaiverOfPremium.ExtendedDeathBenefit.ExtendedDeathBenefitMaximumDuration,
															    WaiverOfPremiumDuration: pdItem.WaiverOfPremium.WaiverOfPremiumDuration,
															    waiverOfPremiumDurationAge: pdItem.WaiverOfPremium.WaiverOfPremiumDurationAge,
															    extendedDeathBenefitDisabledBeforeAge: pdItem.WaiverOfPremium.ExtendedDeathBenefit.ExtendedDeathBenefitUpToAge,	//Corrected as per QE
															    continuationOfDisabilityDuration: pdItem.ContinuationOfDisability.ContinuationOfDisabilityDuration,
															    continuationOfDisabilityStartingAge: pdItem.ContinuationOfDisability.ContinuationOfDisabilityStartingAge,
															    continuationOfDisabilityDurationMonths: pdItem.ContinuationOfDisability.ContinuationOfDisabilityDurationMonths,
															    waiverOfPremiumDisabledBeforeAge: pdItem.WaiverOfPremium.WaiverOfPremiumUpToAge,
															    waiverOfPremiumWaitingPeriod: pdItem.WaiverOfPremium.WaiverOfPremiumWaitingPeriod,
															    waiverOfPremium: pdItem.WaiverOfPremium.WaiverOfPremium, //Its the Parent Node,
															    continuationOfDisability: pdItem.ContinuationOfDisability.ContinuationOfDisability, // Not sure of ContinuationOfDisability element in response.
															    addCoveredLosses: "",	//NM
															    coveredLossBenefitPercentage: "",	//NM
															    addBenefitPercentage: "",	//NM
															    addTypes: 
															    	{
																		addType1: pdItem.ADDType,
																		addType2: pdItem.ADDType,
																	    addType3: pdItem.ADDType,
																	    addType4: pdItem.ADDType,
																	    addType5: pdItem.ADDType,
																	    addType6: pdItem.ADDType,
																	    addType7: pdItem.ADDType,
																	    addType8: pdItem.ADDType,
																	    addType9: pdItem.ADDType,
																	    addType10: pdItem.ADDType,		
											        				},
											        			coverage:  
			        												{
																	  	benefitType:  pdItem.Coverage map(covItem , i) ->{
																	  		coverage: checkCoverageType(covItem.coverageType),
															            	coverageType: checkCoverageType(covItem.coverageType) ,
															            	splitContributionType: "",	//NM
															            	eeSplitContributionType: "", //NM
															            	adAndDRider: covItem.ADDRider,
															            	LifeCoverageEndsAtAge: covItem.BenefitType.LifeCoverageEndsAtAge,
															            	childBenfitBirthTo14Days: covItem.BenefitType.BirthTo14DaysOld,
															            	childBenfit14DaysTo6Month: covItem.BenefitType.Days14To6MonthsOld,
															            	coverageEndAtAgeForFullTimeStudent: covItem.BenefitType.FullTimeStudents,	
															            	coverageEndAtAgeForNotFullTimeStudent: covItem.BenefitType.NonFullTimeStudents,
															            	benefitType: covItem.BenefitType.BenefitType,
															            	flatBenAmount: covItem.BenefitType.FlatBenAmt,
															            	flatBenefitAmount:
															            		{
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
															            	unitsOf: covItem.BenefitType.UnitsOf,
															            	eeUnitsOf: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.BenefitType.UnitsOf else "",	//NM
															            	childUnitsOf: if(covItem.coverageType == "CH" or capitalize(covItem.coverageType) == "Child") covItem.BenefitType.UnitsOf else "",	//NM
															            	spouseUnitsOf: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.BenefitType.UnitsOf else "" ,	//NM
															            	salaryMultiple:
															            		{
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
																            earningType: covItem.BenefitType.EarningsType,
																            benefitMinimum: covItem.BenefitType.BenefitMinimum,
																            benefitMaximum: covItem.BenefitType.BenefitMaximum,
																            guarateedIssueAmount: covItem.BenefitType.GuaranteedIssueAmount,
																            guarateedIssueTimesSalary: covItem.BenefitType.GuaranteedIssueTimesSalary,
																            typeOfAnnualEnrollmentIncrease: covItem.BenefitType.TypeOfAnnualEnrollmentIncrease,
																            unitsOfIncrease: covItem.BenefitType.UnitsIncrease,	
																            percentageOfBenefit: covItem.BenefitType.PercentOfBenefit,
																            percentageBasis: covItem.BenefitType.PercentageBasis,
																            benefitReductionSchedule: covItem.AgeReductions.BenefitReductionSchedule,
																            spouseReductionAgeBasis: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.AgeReductions.ReductionBasis else "",
																            AcceleratedDeathBenefit: covItem.AcceleratedDeathBenefit.AcceleratedDeathBenefit,	
																            acceleratedDeathBenefitMaximum: covItem.AcceleratedDeathBenefit.BenefitMaximum,
																            spouseAcceleratedDeathBenefit: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.AcceleratedDeathBenefit.AcceleratedDeathBenefit else "",
																            childAcceleratedDeathBenefit: if(covItem.coverageType == "CH" or capitalize(covItem.coverageType) == "Child") covItem.AcceleratedDeathBenefit.AcceleratedDeathBenefit else "",
																            upToPercentage: covItem.AcceleratedDeathBenefit.UpToPctSgn,								            
																            benefitMaxTimesSalaryMultiple: covItem.BenefitType.BenefitMaxTimesSalaryMultiple,
																            adAndDRiderType: "",
																            adAndDRiderBenefitPercentage: "",
																            seatbelt: "",
																            commonCarrier: "",
																            commonCarrierPercentage: "",
																            commonCarrierMaximum: "",
																            feloniousAssault: "",
																            feloniousAssaultMaximum: "",
																            feloniousAssaultPercentage: "",
																            seatbeltBenefitPercentage: "",
																            seatbeltBenefitMaximum: "",
																            seatbeltFlatAmount: "",
																            combinedTimesSalary: covItem.BenefitType.CombinedTimesSalary,
																            combinedBenefitMaximum: covItem.BenefitType.CombinedMaximumFlat,
																            employeeBenefitType: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.BenefitType.BenefitType else "",
																            employeeTypeOfAnnualEnrollmentIncrease: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.BenefitType.TypeOfAnnualEnrollmentIncrease else "",
																            employeeUnitsIncrease: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.BenefitType.UnitsIncrease else "",
																            spouseBenefitType: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.BenefitType.BenefitType else "",
																            spouseTypeOfAnnualEnrollmentIncrease: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.BenefitType.TypeOfAnnualEnrollmentIncrease else "",
																            spouseUnitsIncrease: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.BenefitType.UnitsIncrease else "",
																            benefitLevelIncrease: covItem.BenefitType.BenefitLevelIncrease,
																            eeBenefitType: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.BenefitType.BenefitType else "",
																            eeTypeOfAnnualEnrollmentIncrease: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.BenefitType.TypeOfAnnualEnrollmentIncrease else "",
																            eeBenefitLevelIncrease: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.BenefitType.BenefitLevelIncrease else "",
																            spouseBenefitLevelIncrease: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.BenefitType.BenefitLevelIncrease else "",
																            flatDollarAmount: covItem.AcceleratedDeathBenefit.FlatDlrSignAmount,
																            spFlatDollarAmount: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.AcceleratedDeathBenefit.FlatDlrSignAmount else "",
																            EEFlatDollarAmount: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.AcceleratedDeathBenefit.FlatDlrSignAmount else "",
																            employeeAcceleratedDeathBenefit: if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.AcceleratedDeathBenefit.AcceleratedDeathBenefit else "",
																            //percentage: "", Not Needed
																            //percentageContribution: "", Not Needed
																            spouseCompositeRate: "",
																            employeeCompositeRate: "",
																            childContributionPercentage: "", // Already Present in RS
																            commonCarrierFlatAmount: "",
																            feloniousAssaultFlatAmount: "",
																            airbagBenefitPercentage: "",
																            airbagFlat: "",
																            childAccidentalInjuryFlat: "",
																            childDayCareBenefitPercentage: "",
																            childDayCareFlat: "",
																            comaBenefitPercentage: "",
																            commonCarrierBenefitPercentage: "",
																            commonCarrierFlat: "",
																            commonDualAccidentalBenefit: "",
																            commonDualAccidentalFlat: "",
																            dependentChildEligibleWithoutEE: covItem.DependentChildEligibleWOutEEEnrollment,
																            exposureAndDisapperance: "",
																            feloniousAssaultBenefitPercentage: "",
																            feloniousAssaultFlat: "",
																            matchLifeBenefit: "",
																            rehabilitationBenefitPercentage: "",
																            rehabilitationFlat: "",
																            SEB1AdditionalBenefitPercentage: "",
																            SEB2AdditionalBenefitPercentage: "",
																            SEB3ChildAdditionalBenefitPercentage: "",
																            spUnitsOf: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.BenefitType.UnitsOf else "",
																            spouseEligibleWithoutEEEnrollment: covItem.SpouseEligibleWoutEEEnrollment,
																            spouseRetrainingBenefitPercentage: "",
																            spouseRetrainingFlat: "",
																            survivingSpouseBenefitPercentage: "",
																            survivingSpouseFlat: "",
																            airbagBenefitMaximum: "",
																            enhancedOption1Percentage: "",
																            enhancedOption2Percentage: "",
																            enhancedOption1BenefitMaximum: "",
																            enhancedOption2BenefitMaximum: "",
																            traditionalOptionWithChildrenPercentage: "",
																            traditionalOptionWithNoChildPercentage: "",
																            traditionalOptionWithSpousePercentage: "",
																            spouseBenefitMaximum: if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.BenefitType.BenefitMaximum else "",
																            SEB1AdditionalBenefitMax: "",
																            SEB1NumberOfYears: "",
																            SEB1NoQualifyingChildDollars: "",
																            SEB1ChildUnderAge: "",
																            SEB2AdditionalBenefitMax: "",
																            SEB2NumberOfYears: "",
																            SEB2NoQualifyingChildDollars: "",
																            SEB2ChildUnderAge: "",
																            rehabilitationBenefitMaximum: "",
																            childDayCareChildAge: "",
																            childDayCareBenefitMaximum: "",
																            childDayCareChildYears: "",
																            spouseRetrainingBenefitMaximum: "",
																            feloniousAssaultBenefitMaximum: "",
																            survivingSpouseBenefitMaximum: "",
																            survivingSpouseMonths: "",
																            commonDualAccidentBenefitPercentage: "",
																            commonDualAccidentBenefitMaximum: "",
																            commonDualAccidentFlat: "",
																            employeePerUnitRate: "",
																            employeeSplitPercentageContributionPerPaycheckUnitRate: "",
																            employeePerPaycheckPerThousandRate: "",
																            spousePerUnitRate: "",
																            spouseSplitPercentageContributionPerPaycheckUnitRate: "",
																            childPerUnitRate: "",
																            childSplitPercentageContributionPerPaycheckUnitRate: "",
																            voluntaryMaximumCombinedWithBasicMaximum: covItem.BenefitType.VoluntaryMaximumCombinedWithBasicMaximum,
																            voluntaryGICombinedWithBasicGI: covItem.BenefitType.VoluntaryGICombinedWithBasicGI, 
																            //payrollFrequency: "",		// It should be in rate Structure Group Plan
																			rateStructure: planItem.RateStructureGroupPlan map (rsItem , rsindex) ->  
																				{
																		            spouseCompositeRate: "",
																		            familyCompositeRate: "",
																		            employeeCompositeRate: "", 
																		            spouseRateBasis: rsItem.RateStructureGroupSpouse.SpouseRateBasis, //if(covItem.coverageType == "SPS" or capitalize(covItem.coverageType) == "Spouse") covItem.RateStructureGroup.RateBasis  else "",            
																		            ageBandApplies: covItem.RateStructureGroup.AgeBandApplies,
																		            smokerStatusApplies: covItem.RateStructureGroup.SmokerStatusApplies,
																					UnismokerRates: "",				
																					pasteFromSpreadSheet: "",
																					spouseContributionType: rsItem.RateStructureGroupSpouse.SpouseContributionType,
																					spouseContributionPercentage: rsItem.RateStructureGroupSpouse.ContributionTypePercentage,
																					contributionTypePercentage: "",
																					//contributionTypeFlat: "", Not Needed
																					employeeContributionTypeFlatAmount: rsItem.RateStructureGroupEmployee.ContributionTypeFlatAmount,
																					childRateBasis: rsItem.RateStructureGroupCHorFAM.ChildRateBasis, //if(covItem.coverageType == "CH" or capitalize(covItem.coverageType) == "Child") covItem.RateStructureGroup.RateBasis  else "",
																					childContributionType: rsItem.RateStructureGroupCHorFAM.ChildContributionType,
																					spouseContributionTypeFlatAmount: rsItem.RateStructureGroupSpouse.ContributionTypeFlatAmount,
																					childContributionTypeFlatAmount: rsItem.RateStructureGroupCHorFAM.ContributionTypeFlatAmount,
																					familyContributionTypeFlatAmount: rsItem.RateStructureGroupCHorFAM.ContributionTypeFlatAmount,
																					familyRateBasis: rsItem.RateStructureGroupCHorFAM.FamilyRateBasis,
																					familyContributionType: rsItem.RateStructureGroupCHorFAM.FamilyContributionType,
																					employeeRateBasis: rsItem.RateStructureGroupEmployee.EmployeeRateBasis, //if(covItem.coverageType == "EE" or capitalize(covItem.coverageType) == "Employee") covItem.RateStructureGroup.RateBasis else "",
																					eeSmokerRates: "",
																					eeNonSmokerRates: "",
																					contributionType: "",
																					percentage: "",
																					employeeRate: rsItem.RateStructureGroupEmployee.EmployeeRate,
																					spouseRate: rsItem.RateStructureGroupSpouse.SpouseRate,
																					familyRate: rsItem.RateStructureGroupCHorFAM.FamilyRate,
																					childRate: rsItem.RateStructureGroupCHorFAM.ChildRate,
																					EECHRate: rsItem.RateStructureGroupCHorFAM.EECHRate,
																					EESPRate: rsItem.RateStructureGroupCHorFAM.EESPRate,
																					//percentageContribution: "", Not Needed
																					childContributionPercentage: rsItem.RateStructureGroupCHorFAM.ContributionTypePercentage,
																					eeContributionType: rsItem.RateStructureGroupEmployee.EmployeeContributionType,
																					eespContributionType: rsItem.RateStructureGroupCHorFAM.EESPContribution,
																					eechContributionType: rsItem.RateStructureGroupCHorFAM.EECHContribution,
																					employeeContributionPercentage: rsItem.RateStructureGroupEmployee.ContributionTypePercentage,
																					familyContributionPercentage: rsItem.RateStructureGroupCHorFAM.ContributionTypePercentage,
																					eechRateBasis: rsItem.RateStructureGroupCHorFAM.EECHRateBasis,
																					eespRateBasis: rsItem.RateStructureGroupCHorFAM.EESPRateBasis,
																					employeeSplitContributionPercentagePerPaycheckPerThousandRate: "",
																					employeeSplitContributionPercentagePerPaycheckPerTenThousandRate: "",
																					employeePerPaycheckPerTenThousandRate: "",
																					spousePerPaycheckPerThousandRate: "",
																					spousePerPaycheckPerFiveThousandRate: "",
																					spouseSplitContributionPercentagePerPaycheckPerThousandRate: "",
																					spouseSplitContributionPercentagePerPaycheckPerFiveThousandRate: "",
																					childPerPaycheckPerThousandRate: "",
																					childPerPaycheckPerTwoThousandRate: "",
																					childSplitContributionPercentagePerPaycheckPerThousandRate: "",
																					childSplitContributionPercentagePerPaycheckPerTwoThousandRate: "",
																					employeePerPayFlatContribution: "",
																					spousePerPayFlatContribution: "",
																					familyPerPayFlatContribution: "",
																					eespPerPayFlatContribution: "",
																					eechPerPayFlatContribution: "",
																					eespPerPaycheckPerThousandRate: "",
																					eespSplitContributionPercentagePerPaycheckPerThousandRate: "",
																					eechPerPaycheckPerThousandRate: "",
																					eechSplitContributionPercentagePerPaycheckPerThousandRate: "",
																					familyPerPaycheckPerThousandRate: "",
																					familySplitContributionPercentagePerPaycheckPerThousandRate: "",
																					smokerRates: if(covItem.RateStructureGroup.SmokerStatusApplies == true){
																						smokerRate: if(covItem.RateStructureGroup.RateStructure[0].Smoker == "Smoker") 
																						covItem.RateStructureGroup.RateStructure[0].RateStructureEntry map(sItem , sIndex) -> {
																							ageFrom: sItem.AgeFrom,
																							ageTo:sItem.AgeTo,
																							billedRate: sItem.BilledRate,
																							billedVolume: sItem.BilledVolume,
																							billedPremium: sItem.BilledPremium,
																							name: "",
																							familyRate: "",
																							rateStructureEntryFlatBenAmt: ""
																							
																						}	else ""
																					
																					} else "",
																					nonSmokerRates: if(covItem.RateStructureGroup.SmokerStatusApplies == true)
																					{
																					nonSmokerRate: if(covItem.RateStructureGroup.RateStructure[0].Smoker == "Non Smoker") 
																					covItem.RateStructureGroup.RateStructure[0].RateStructureEntry map(nsItem , sIndex) -> {
																						ageFrom: nsItem.AgeFrom,
																						ageTo:nsItem.AgeTo,
																						billedRate: nsItem.BilledRate,
																						billedVolume: nsItem.BilledVolume,
																						billedPremium: nsItem.BilledPremium,
																						name: "",
																						familyRate: "",
																						rateStructureEntryFlatBenAmt: ""
																						
																					}	else if(covItem.RateStructureGroup.RateStructure[1].Smoker == "Non Smoker") 
																					covItem.RateStructureGroup.RateStructure[1].RateStructureEntry map(nsItem , sIndex) -> {
																						ageFrom: nsItem.AgeFrom,
																						ageTo:nsItem.AgeTo,
																						billedRate: nsItem.BilledRate,
																						billedVolume: nsItem.BilledVolume,
																						billedPremium: nsItem.BilledPremium,
																						name: "",
																						familyRate: "",
																						rateStructureEntryFlatBenAmt: ""
																						
																					} else ""
																					
																					} else "" 										
															        			}, // ***************End of Rate Structure *****************							        	
														        		rounding:
											         						{
																            	roundingRule: covItem.BenefitType.RoundingRule,
																            	roundingAmount: covItem.BenefitType.RoundingAmount ,
																            	roundingRuleAppliesTo: covItem.BenefitType.RoundingRuleAppliesTo
																        	}
											        					}	// End of BenefitType
							        	      						}	//End of Coverage
							        	      					}	// End of Plan Design
							        	      				},	// End of Eligible Class
							        	      			rateStructureGroupPlan: planItem.RateStructureGroupPlan map (rsGrpItem , rsindex) ->  
								       						{
											        			employeeContributionType: rsGrpItem.RateStructureGroupEmployee.EmployeeContributionType,
											        			employeeRateBasis: rsGrpItem.RateStructureGroupEmployee.EmployeeRateBasis ,
											        			payrollFrequency: rsGrpItem.RateStructureGroupEmployee.PayrollFrequency,
											        			selectedPlanDesignsForRateStructureGroupPlan: rsGrpItem.selectedPlanDesigns,
											        			contributionTypeFlat: rsGrpItem.RateStructureGroupEmployee.ContributionTypeFlatAmount,
											        			contributionTypePercentage: rsGrpItem.RateStructureGroupEmployee.ContributionTypePercentage,
											        			employeeRate: rsGrpItem.RateStructureGroupEmployee.EmployeeRate,			        			
											        			employeeRateBasis: rsGrpItem.RateStructureGroupEmployee.EmployeeRateBasis,
											        			isOtherpayrollFrequency:rsGrpItem.RateStructureGroupEmployee.Other,
											        			smokerRates: if(rsGrpItem.RateStructureGroupEmployee.SmokerStatusApplies == true){
																					smokerRate: if(rsGrpItem.RateStructureGroupEmployee.RateStructure[0].Smoker == "Smoker") 
																					rsGrpItem.RateStructureGroupEmployee.RateStructure[0].RateStructureEntry map(sItem , sIndex) -> {
																						ageFrom: sItem.AgeFrom,
																						ageTo:sItem.AgeTo,
																						billedRate: sItem.BilledRate,
																						billedVolume: sItem.BilledVolume,
																						billedPremium: sItem.BilledPremium,
																						name: sItem.name,
																						familyRate: sItem.FamilyRate,
																						rateStructureEntryFlatBenAmt: sItem.FlatBenAmt
																						
																					}	else ""
																					
																					} else "",
																					nonSmokerRates: if(rsGrpItem.RateStructureGroupEmployee.SmokerStatusApplies == true)
																					{
																					nonSmokerRate: if(rsGrpItem.RateStructureGroupEmployee.RateStructure[0].Smoker == "Non Smoker") 
																					rsGrpItem.RateStructureGroupEmployee.RateStructure[0].RateStructureEntry map(nsItem , sIndex) -> {
																						ageFrom: nsItem.AgeFrom,
																						ageTo: nsItem.AgeTo,
																						billedRate: nsItem.BilledRate,
																						billedVolume: nsItem.BilledVolume,
																						billedPremium: nsItem.BilledPremium,
																						name: nsItem.name,
																						familyRate: nsItem.FamilyRate,
																						rateStructureEntryFlatBenAmt: nsItem.FlatBenAmt
																						
																					}	else if(rsGrpItem.RateStructureGroupEmployee.RateStructure[1].Smoker == "Non Smoker") 
																					rsGrpItem.RateStructureGroupEmployee.RateStructure[1].RateStructureEntry map(nsItem , sIndex) -> {
																						ageFrom: nsItem.AgeFrom,
																						ageTo: nsItem.AgeTo,
																						billedRate: nsItem.BilledRate,
																						billedVolume: nsItem.BilledVolume,
																						billedPremium: nsItem.BilledPremium,
																						name: nsItem.name,
																						familyRate: nsItem.FamilyRate,
																						rateStructureEntryFlatBenAmt: nsItem.FlatBenAmt
																						
																					} else ""
																					
																					} else ""
											        		}
											        },	// End of Plan 
											    copyRights: "" //NM                     							
			        					})	//End of Line of Buisness  
			        			}	// End of Summary of Benefits 
			        		}	 // End of compositeTransaction
			        	}	//End of assembledTransaction 
		        	},	// End of fja
			}	// End of transaction 
	}
}