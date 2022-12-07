%dw 2.0
import * from dw::core::Strings
output application/xml
var packageResp = vars.packageResp
var opportunityResp = vars.opportunityResp
fun checkProduct(product: String) = 
	if(product == "Basic Term Life") "BTL" else  
	if(product == "Voluntary Term Life") "VTL" else 
	if(product == "Basic AD&D") "BADD" else if(product == "Voluntary AD&D") "VADD" else "Not a Valid Product"

fun checkCoverageType(covType: String) = 
	if(covType == "Employee") "EE" else
	if(covType == "Spouse") "SPS" else 
	if(covType == "Child") "CH" else 
	if(covType == "Family") "FAM" else "Invalid Coverage Type"
	
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
			                        postalCode: 50338,
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
			                        postalCode: 50338,
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
			                        prefixNew: "",
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
				                            postalCode: 30338,
				                            country: "US",
				                            countryCode: 111
			                        	},
		                        	email: 
				                        {
				                            "type": "Unknown",
				                            emailAddress: Mule::p("pRecepient.email.address")
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
			            	documentClass: "FJAEnrollmentMaterial",
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
			        						lineOfBusiness: packageResp.Plan map ((planItem , pindex) -> 
			        							if(planItem.EligibilityClass != null)
			        							{
			        							productCode: checkProduct(planItem.productType),
                    							caseProperty: 
                    								{
                            							accountName: opportunityResp.Role[0].Name
                    								},
                    							plan: 
                    								{
								                    	situsState: planItem.situsState,
								                    	product: planItem.productType as String,
								                    	creationDate: (packageResp.createDate as Number / 1000) as DateTime as String {format:"ddMMyyyy"},
								                    	policyNumber: planItem.PlanPolicyNumber,
								                    	documentGenerationDate: now() as DateTime as String{format: "ddMMyyyy"},
                    									eligibleClass: planItem.EligibilityClass map (eligibilityClsItem , eindex) -> {
								                        	locationName: eligibilityClsItem.LocationName,
								                        	className: eligibilityClsItem.eligibilityClassName,
								                        	classDescription: eligibilityClsItem.eligibilityClassDescription,
								                        	eligibilityWaitingPeriod: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriod,
								                        	eligibilityWaitingPeriodDays: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodDays,
								                        	eligibilityWaitingPeriodMonths: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodMonths,
								                        	eligibilityWaitingPeriodOther: eligibilityClsItem.EligibilityWaitingPeriod.EligibilityWaitingPeriodOther,
												    		matchLifeBenefit: eligibilityClsItem.MatchLifeBenefits,
												    		planDesign: eligibilityClsItem.PlanDesign map (pdItem , eindex) -> {												    				
												    			planDesignId: pdItem.planDesignId,
												    			portabilityEligibility: pdItem.ConversionAndPortability.PortabilityEligibility,
								                    			portabilityDuration: pdItem.ConversionAndPortability.PortabilityDuration,
								                    			portabilityDurationAge: pdItem.ConversionAndPortability.PortabilityDurationAge,
								                    			portabilityDurationYears: pdItem.ConversionAndPortability.PortabilityDurationYears,
								                    			ConversionNumberOfDaysToApply: pdItem.ConversionAndPortability.ConversionNumberOfDaysToApply,
															    dependentCoverage: if(typeOf(pdItem.DependentEligibility) == Array) pdItem.DependentEligibility joinBy(",") else pdItem.DependentEligibility,
															    dependentEligibility: if(typeOf(pdItem.DependentEligibility) == Array) pdItem.DependentEligibility joinBy(",") else pdItem.DependentEligibility,				      
															    domesticPartnerEligible: pdItem.DomesticPartnerEligible ,
															    extendedDeathBenefit: pdItem.WaiverOfPremium.ExtendedDeathBenefit.ExtendedDeathBenefit,
															    extendedDeathBenefitMaximumDuration: pdItem.WaiverOfPremium.ExtendedDeathBenefit.ExtendedDeathBenefitMaximumDuration,
															    extendedDeathBenefitDisabledBeforeAge: pdItem.WaiverOfPremium.ExtendedDeathBenefit.ExtendedDeathBenefitUpToAge,	
															    waiverOfPremiumDuration: pdItem.WaiverOfPremium.WaiverOfPremiumDuration,
															    waiverOfPremiumDurationAge: pdItem.WaiverOfPremium.WaiverOfPremiumDurationAge,
															    waiverOfPremiumDisabledBeforeAge: pdItem.WaiverOfPremium.WaiverOfPremiumUpToAge,
															    waiverOfPremiumWaitingPeriod: pdItem.WaiverOfPremium.WaiverOfPremiumWaitingPeriod,
															    waiverOfPremium: pdItem.WaiverOfPremium.WaiverOfPremium,
															    continuationOfDisabilityDuration: pdItem.ContinuationOfDisability.ContinuationOfDisabilityDuration,
															    continuationOfDisabilityDurationMonths: pdItem.ContinuationOfDisability.ContinuationOfDisabilityDurationMonths,
															    continuationOfDisabilityStartingAge: pdItem.ContinuationOfDisability.ContinuationOfDisabilityStartingAge,
															    continuationOfDisability: pdItem.ContinuationOfDisability.ContinuationOfDisability,
															    addTypes: if(!isEmpty(pdItem.ADDType))
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
											        				} else "",
											        			coverage:  
			        												{
																	  	benefitType:  pdItem.Coverage map(covItem , i) ->{
																	  		coverage: checkCoverageType(covItem.coverageType),
															            	coverageType: checkCoverageType(covItem.coverageType) ,
															            	splitContributionType: "",	//NM
															            	dependentChildEligibleWithoutEE: covItem.DependentChildEligibleWOutEEEnrollment,
															            	//------------------ Benefit Types Elements---------------------
															            	lifeCoverageEndsAtAge: covItem.BenefitType.LifeCoverageEndsAtAge,
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
															            	childFlatBenefitAmount: 
															            		{
															            			flatBenefitAmount1:covItem.BenefitType.ChildFlatBenefitAmount1,
																            		flatBenefitAmount2:covItem.BenefitType.ChildFlatBenefitAmount2,
																            		flatBenefitAmount3:covItem.BenefitType.ChildFlatBenefitAmount3,
																            		flatBenefitAmount4:covItem.BenefitType.ChildFlatBenefitAmount4,
																            		flatBenefitAmount5:covItem.BenefitType.ChildFlatBenefitAmount5,
																            		flatBenefitAmount6:covItem.BenefitType.ChildFlatBenefitAmount6,
																            		flatBenefitAmount7:covItem.BenefitType.ChildFlatBenefitAmount7,
																            		flatBenefitAmount8:covItem.BenefitType.ChildFlatBenefitAmount8,
																            		flatBenefitAmount9:covItem.BenefitType.ChildFlatBenefitAmount9,
																            		flatBenefitAmount10:covItem.BenefitType.ChildFlatBenefitAmount10
															            		},
															            	spouseFlatBenefitAmount:
															            		{
															            			flatBenefitAmount1:covItem.BenefitType.SpouseFlatBenefitAmount1,
																            		flatBenefitAmount2:covItem.BenefitType.SpouseFlatBenefitAmount2,
																            		flatBenefitAmount3:covItem.BenefitType.SpouseFlatBenefitAmount3,
																            		flatBenefitAmount4:covItem.BenefitType.SpouseFlatBenefitAmount4,
																            		flatBenefitAmount5:covItem.BenefitType.SpouseFlatBenefitAmount5,
																            		flatBenefitAmount6:covItem.BenefitType.SpouseFlatBenefitAmount6,
																            		flatBenefitAmount7:covItem.BenefitType.SpouseFlatBenefitAmount7,
																            		flatBenefitAmount8:covItem.BenefitType.SpouseFlatBenefitAmount8,
																            		flatBenefitAmount9:covItem.BenefitType.SpouseFlatBenefitAmount9,
																            		flatBenefitAmount10:covItem.BenefitType.SpouseFlatBenefitAmount10
															            		},
															            	unitsOf: covItem.BenefitType.UnitsOf,
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
																            unitsIncrease: covItem.BenefitType.UnitsIncrease,	
																            percentageOfBenefit: covItem.BenefitType.PercentOfBenefit,
																            percentageBasis: covItem.BenefitType.PercentageBasis,
																            combinedTimesSalary: covItem.BenefitType.CombinedTimesSalary,
																            combinedBenefitMaximum: covItem.BenefitType.CombinedMaximumFlat,
																            benefitLevelIncrease: covItem.BenefitType.BenefitLevelIncrease,
																            benefitMaxTimesSalaryMultiple: covItem.BenefitType.BenefitMaxTimesSalaryMultiple,
																            typeOfAnnualEnrollmentIncrease: covItem.BenefitType.TypeOfAnnualEnrollmentIncrease,
																            voluntaryGICombinedWithBasicGI: covItem.BenefitType.VoluntaryGICombinedWithBasicGI,
																            voluntaryMaximumCombinedWithBasicMaximum: covItem.BenefitType.VoluntaryMaximumCombinedWithBasicMaximum,
																            coverageEndsAtAge: covItem.BenefitType.CoverageEndsAtAge,
																            //-------------------------Age Reduction Elements --------------------------------------
																            benefitReductionSchedule: covItem.AgeReductions.AgeReductType,
																            reductionsBasis: covItem.AgeReductions.ReductionBasis,
																            spouseReductionAgeBasis: covItem.AgeReductions.SpouseReductionAgeBasis,
																            //--------------------------Accelerated Death Benefit Elements----------------------------
																            acceleratedDeathBenefit: covItem.AcceleratedDeathBenefit.AcceleratedDeathBenefit,
															            	acceleratedDeathBenefitMaximum: covItem.AcceleratedDeathBenefit.BenefitMaximum,
															            	upToPercentage: covItem.AcceleratedDeathBenefit.UpToPctSgn,
															            	flatDollarAmount: covItem.AcceleratedDeathBenefit.FlatDlrSignAmount,
																            //------------------------Accident Elements ---------------------------------------------
																            adAndDRider: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.ADDRider else covItem.ADDScheduleOfBenefits.ADDScheduleOfBenefits,								            
																            comaBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.ComaMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.ComaMaxBenefitPct,
																            exposureAndDisapperance: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.ExposureAndDissapearance else covItem.ADDScheduleOfBenefits.AdditionalFeatures.ExposureAndDissapearance,
																            
																            seatbelt: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.Seatbelt else covItem.ADDScheduleOfBenefits.AdditionalFeatures.Seatbelt,
																            seatbeltBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SeatbeltMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SeatbeltMaxBenefitPct,
																            seatbeltBenefitMaximum: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SeatbeltBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SeatbeltBenefitMaximum,
																            seatbeltFlatAmount:if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SeatbeltFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SeatbeltFlat,
																            
																            commonCarrier:if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.CommonCarrier else covItem.ADDScheduleOfBenefits.AdditionalFeatures.CommonCarrier,
																            commonCarrierMaximum: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.CommonCarrierBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.CommonCarrierBenefitMaximum,
																            commonCarrierFlatAmount: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.CommonCarrierFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.CommonCarrierFlat,
																            commonCarrierBenefitPercentage:if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.CommonCarrierMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.CommonCarrierMaxBenefitPct,
																            commonDualAccident:if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.CommonDualAccident else covItem.ADDScheduleOfBenefits.AdditionalFeatures.CommonDualAccident,
																            commonDualAccidentBenefitPercentage:if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.CommonDualAccidentMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.CommonDualAccidentMaxBenefitPct,
																            commonDualAccidentBenefitMaximum:if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.CommonDualAccidentBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.CommonDualAccidentBenefitMaximum,
																            commonDualAccidentFlat:if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.CommonDualAccidentFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.CommonDualAccidentFlat,
																            
																            feloniousAssault: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.FeloniousAssault else covItem.ADDScheduleOfBenefits.AdditionalFeatures.FeloniousAssault,
																            feloniousAssaultFlatAmount: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.FeloniousAssaultFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.FeloniousAssaultFlat,
																            feloniousAssaultBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.FeloniousAssaultMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.FeloniousAssaultMaxBenefitPct,
																            feloniousAssaultBenefitMaximum: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.FeloniousAssaultBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.FeloniousAssaultBenefitMaximum,
																            
																            childAccidentalInjuryFlat: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.ChildAccidentalInjuryFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.ChildAccidentalInjuryFlat,
																            childDayCareBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.ChildDayCareMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.ChildDayCareMaxBenefitPct,
																            childDayCareFlat: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.ChildDayCareFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.ChildDayCareFlat,
																            childDayCareChildAge: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.ChildDayCareChildAge else covItem.ADDScheduleOfBenefits.AdditionalFeatures.ChildDayCareChildAge,
																            childDayCareBenefitMaximum: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.ChildDayCareBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.ChildDayCareBenefitMaximum,
																            childDayCareChildYears: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.ChildDayCareChildYears else covItem.ADDScheduleOfBenefits.AdditionalFeatures.ChildDayCareChildYears,
																            
																            rehabilitationBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.RehabilitationMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.RehabilitationMaxBenefitPct,
																            rehabilitationFlat: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.RehabilitationFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.RehabilitationFlat,
																            rehabilitationBenefitMaximum: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.RehabilitationBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.RehabilitationBenefitMaximum,
																            
																            spouseEligibleWithoutEEEnrollment: covItem.SpouseEligibleWoutEEEnrollment,
																            spouseRetrainingBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SpouseRetrainingMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SpouseRetrainingMaxBenefitPct,
																            spouseRetrainingFlat: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SpouseRetrainingFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SpouseRetrainingFlat,
																            spouseRetrainingBenefitMaximum: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SpouseRetrainingBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SpouseRetrainingBenefitMaximum,
																            
																            survivingSpouseBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SurvivingSpouseMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SurvivingSpouseMaxBenefitPct,
																            survivingSpouseFlat: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SurvivingSpouseFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SurvivingSpouseFlat,
																            survivingSpouseBenefitMaximum: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SurvivingSpouseBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SurvivingSpouseBenefitMaximum,
																            survivingSpouseMonths: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SurvivingSpouseSpouseMonths else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SurvivingSpouseSpouseMonths,
																            
																            airbagBenefitMaximum: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.AirbagBenefitMaximum else covItem.ADDScheduleOfBenefits.AdditionalFeatures.AirbagBenefitMaximum,
																            airbagBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.AirbagMaxBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.AirbagMaxBenefitPct,
																            airbagFlat: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.AirbagFlat else covItem.ADDScheduleOfBenefits.AdditionalFeatures.AirbagFlat,
																            
																            enhancedOption1Percentage: covItem.EnhancedOptions.EnhancedOpt1Pct,
																            enhancedOption2Percentage: covItem.EnhancedOptions.EnhancedOpt2Pct,
																            enhancedOption1BenefitMaximum: covItem.EnhancedOptions.EnhancedOpt1BenMax,
																            enhancedOption2BenefitMaximum: covItem.EnhancedOptions.EnhancedOpt2BenMax,
																            
																            traditionalOptionWithChildrenPercentage: covItem.Child.TraditionalOpt.TraditionalOptChildrenPct,
																            traditionalOptionWithNoChildPercentage: covItem.Child.TraditionalOpt.TraditionalOptWNoChildPct,
																            traditionalOptionWithSpousePercentage: covItem.Spouse.TraditionalOpt.TraditionalOptSpousePct,
																            traditionalOptionWithNoSpousePercentage: covItem.Spouse.TraditionalOpt.TraditionalOptWNoSpousePct,
																            traditionalOptionChildBenefitMaximum: covItem.Child.TraditionalOpt.BenefitMaximum,
																            traditionalOptionSpouseBenefitMaximum: covItem.Spouse.TraditionalOpt.BenefitMaximum,
																            
																            sebSpouseAdditionalBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBSpAdditionalBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBSpAdditionalBenefitPct,
																            sebChildAdditionalBenefitPercentage: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBChAdditionalBenefitPct else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBChAdditionalBenefitPct,
																            sebChildAdditionalBenefitMax: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBChAdditionalBenefitMax else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBChAdditionalBenefitMax,	
																            sebSpouseAdditionalBenefitMax:if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBSpAdditionalBenefitMax else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBSpAdditionalBenefitMax,
																            sebSpouseNumberOfYears: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBSpNumberOfYrs else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBSpNumberOfYrs,
																            sebChildNumberOfYears: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBChNumOfYears else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBChNumOfYears,
																            sebNoQualifyingSpouseDollars: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBSpNonQualifyingDollars else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBSpNonQualifyingDollars,	
																            sebNoQualifyingChildDollars: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBChNonQualifyingDollars else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBChNonQualifyingDollars,
																            sebChildUnderAge: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.AdditionalFeatures.SEBChUnderAge else covItem.ADDScheduleOfBenefits.AdditionalFeatures.SEBChUnderAge,
																            
																			addRiderEntry: if(isEmpty(covItem.ADDScheduleOfBenefits)) covItem.ADDRider.ADDRiderEntry map(addItem , addIndex) -> {
																				adAndDRiderType: addItem.ADDRiderType,
																				adAndDRiderBenefitPercentage: addItem.ADDRiderBenefitPercentage,
																			} else covItem.ADDScheduleOfBenefits.ADDScheduleOfBenefitsEntry map(addItem , addIndex) -> {
																				adAndDScheduleOfCoveredLossesType: addItem.ADDScheduleOfCoveredLossesType,
																				adAndDRiderBenefitPercentage: addItem.ADDRiderBenefitPercentage,
																				adAndDCoveredLossesBenefitPercentage: addItem.ADDCoveredLossesBenefitPercentage
																			},
																			
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
								       							
								       							selectedPlanDesignsForRateStructureGroupPlan: rsGrpItem.selectedPlanDesigns,
											        			selectedRateStructureGroupPlanName: rsGrpItem.name,
											        			
											        			employee: 
											        				{
											        					contributionType: rsGrpItem.RateStructureGroupEmployee.EmployeeContributionType,
											        					contributionTypePercentage: rsGrpItem.RateStructureGroupEmployee.ContributionTypePercentage,
											        					contributionTypeFlatAmount: rsGrpItem.RateStructureGroupEmployee.ContributionTypeFlatAmount,
											        					rate: rsGrpItem.RateStructureGroupEmployee.EmployeeRate,
											        					rateBasis: rsGrpItem.RateStructureGroupEmployee.EmployeeRateBasis,
											        					genderApplies: rsGrpItem.RateStructureGroupEmployee.GenderApplies,
											        					ageBandApplies: rsGrpItem.RateStructureGroupEmployee.AgeBandApplies,
											        					smokerStatusApplies: rsGrpItem.RateStructureGroupEmployee.SmokerStatusApplies,
											        					payrollFrequency: rsGrpItem.RateStructureGroupEmployee.PayrollFrequency,
											        					isOtherpayrollFrequency: rsGrpItem.RateStructureGroupEmployee.Other,
											        					rateStructureEntry: rsGrpItem.RateStructureGroupEmployee.RateStructure map(item , index) ->
																			{
																				smokerType: item.Smoker,
																				billedRate: item.BilledRate,
																				rates: item.RateStructureEntry map(sItem , sIndex) -> 
																					{
																						ageFrom: sItem.AgeFrom,
																						ageTo:sItem.AgeTo,
																						billedRate: sItem.BilledRate,
																						billedVolume: sItem.BilledVolume,
																						billedLives: sItem.BilledLives,
																						billedPremium: sItem.BilledPremium,
																						spouseFlatBenefitAmount: "",
																						childFlatBenefitAmount: "",
																						name: sItem.name,
																						familyRate: sItem.FamilyRate,
																						rateStructureEntryFlatBenAmt: sItem.FlatBenAmt
																					}
																			}
											        				},
											        			spouse: if(!isEmpty(rsGrpItem.RateStructureGroupSpouse))
											        				{
											        					contributionType: rsGrpItem.RateStructureGroupSpouse.SpouseContributionType,
											        					contributionTypePercentage: rsGrpItem.RateStructureGroupSpouse.ContributionTypePercentage,
											        					contributionTypeFlatAmount: rsGrpItem.RateStructureGroupSpouse.ContributionTypeFlatAmount,
											        					rate: rsGrpItem.RateStructureGroupSpouse.SpouseRate,
											        					rateBasis: rsGrpItem.RateStructureGroupSpouse.SpouseRateBasis,
											        					genderApplies: rsGrpItem.RateStructureGroupSpouse.GenderApplies,
											        					ageBandApplies: rsGrpItem.RateStructureGroupSpouse.AgeBandApplies,
											        					smokerStatusApplies: rsGrpItem.RateStructureGroupSpouse.SmokerStatusApplies,
											        					payrollFrequency: "",
											        					isOtherpayrollFrequency: "",
											        					rateStructureEntry: rsGrpItem.RateStructureGroupSpouse.RateStructure map(item , index) ->
																			{
																				smokerType: item.Smoker,
																				billedRate: item.BilledRate,
																				rates: item.RateStructureEntry map(sItem , sIndex) -> 
																					{
																						ageFrom: sItem.AgeFrom,
																						ageTo:sItem.AgeTo,
																						billedRate: sItem.BilledRate,
																						billedVolume: sItem.BilledVolume,
																						billedLives: sItem.BilledLives,
																						billedPremium: sItem.BilledPremium,
																						spouseFlatBenefitAmount: "",
																						childFlatBenefitAmount: "",
																						name: sItem.name,
																						familyRate: sItem.FamilyRate,
																						rateStructureEntryFlatBenAmt: sItem.FlatBenAmt
																					}
																			}
											        				} else "",
											        			child: if(!isEmpty(rsGrpItem.RateStructureGroupCHorFAM) and capitalize(rsGrpItem.RateStructureGroupCHorFAM.ApplicableCoverage) == "Child")
											        				{
											        					contributionType: rsGrpItem.RateStructureGroupCHorFAM.ChildContributionType,
											        					contributionTypePercentage: rsGrpItem.RateStructureGroupCHorFAM.ContributionTypePercentage,
											        					contributionTypeFlatAmount: rsGrpItem.RateStructureGroupCHorFAM.ContributionTypeFlatAmount,
											        					rate: rsGrpItem.RateStructureGroupCHorFAM.ChildRate,
											        					rateBasis: rsGrpItem.RateStructureGroupCHorFAM.ChildRateBasis,
											        				} else "",
											        			family: if(!isEmpty(rsGrpItem.RateStructureGroupCHorFAM) and capitalize(rsGrpItem.RateStructureGroupCHorFAM.ApplicableCoverage) == "Family")
											        				{
											        					contributionType: rsGrpItem.RateStructureGroupCHorFAM.FamilyContributionType,
											        					contributionTypePercentage: rsGrpItem.RateStructureGroupCHorFAM.ContributionTypePercentage,
											        					contributionTypeFlatAmount: rsGrpItem.RateStructureGroupCHorFAM.ContributionTypeFlatAmount,
											        					rate: rsGrpItem.RateStructureGroupCHorFAM.FamilyRate,
											        					rateBasis: rsGrpItem.RateStructureGroupCHorFAM.FamilyRateBasis,
											        				} else "",
											        			eech: if(!isEmpty(rsGrpItem.RateStructureGroupCHorFAM))
											        			{
											        				contributionType: rsGrpItem.RateStructureGroupCHorFAM.EECHContribution,
											        				contributionTypePercentage: rsGrpItem.RateStructureGroupCHorFAM.EECHPercentage,
											        				contributionTypeFlatAmount: rsGrpItem.RateStructureGroupCHorFAM.EECHFlatAmount,
											        				rate: rsGrpItem.RateStructureGroupCHorFAM.EECHRate,
											        				rateBasis: rsGrpItem.RateStructureGroupCHorFAM.EECHRateBasis
											        			} else "",
											        			eesp: if(!isEmpty(rsGrpItem.RateStructureGroupCHorFAM))
											        			{
											        				contributionType: rsGrpItem.RateStructureGroupCHorFAM.EESPContribution,
											        				contributionTypePercentage: rsGrpItem.RateStructureGroupCHorFAM.EESPSPercentage,
											        				contributionTypeFlatAmount: rsGrpItem.RateStructureGroupCHorFAM.EESPSFlatAmount,
											        				rate: rsGrpItem.RateStructureGroupCHorFAM.EESPRate,
											        				rateBasis: rsGrpItem.RateStructureGroupCHorFAM.EESPRateBasis
											        			} else "",
											        		}
											        },	// End of Plan 
											    copyRights: "" //NM                     							
			        					} else "")	//End of Line of Buissnes 
			        			}	// End of Summary of Benefits 
			        		}	 // End of compositeTransaction
			        	}	//End of assembledTransaction 
		        	},	// End of fja
			}	// End of transaction 
	}
}