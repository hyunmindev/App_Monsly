//
//  ResultView.swift
//  Monsly
//
//  Created by 정현민 on 2020/09/02.
//  Copyright © 2020 Hyunmin. All rights reserved.
//

import SwiftUI

struct ResultView: View {
  var deposit_amount: Double = 0
  var loan_amount: Double = 0
  var rent_amount: Double = 0
  var management_amount: Double = 0
  var is_loan: Bool = false
  
  var deposit_interest_rate: Double = 0.0175
  var loan_interest_rate: Double = 0
  
  var real_laon_amount: Double {
    if is_loan {
      return loan_amount
    } else {
      return 0
    }
  }
  var deposit_interest: Double {
    (deposit_amount - loan_amount) * deposit_interest_rate
  }
  var loan_interest: Double {
    loan_amount * loan_interest_rate
  }
  var consumption_amount: Double {
    (deposit_interest + loan_interest) / 12 + rent_amount + management_amount
  }
  
  var body: some View {
    Form {
      Section(header: Text("입력 정보")) {
        HStack {
          Text("보증금")
          Spacer()
          if deposit_amount >= 10000 {
            Text("\(floor(deposit_amount / 10000), specifier: "%0.f") 억")
              .font(.body)
          }
          Text("\(deposit_amount.truncatingRemainder(dividingBy: 10000), specifier: "%0.f") 만원")
            .font(.body)
        }
        HStack {
          Text("월세")
          Spacer()
          Text("\(rent_amount, specifier: "%0.f") 만원")
        }
        if is_loan == true {
          HStack {
            Text("전세 대출금")
            Spacer()
            Text("\(loan_amount, specifier: "%0.f") 만원")
          }
          HStack {
            Text("실질 보증금")
            Spacer()
            Text("\(deposit_amount - loan_amount, specifier: "%0.f") 만원")
          }
          HStack {
            Text("전세 이자율")
            Spacer()
            Text("\(loan_interest_rate * 100, specifier: "%0.2f") %")
          }
        }
      }
      
      Section(header: Text("개요")) {
        HStack {
          if is_loan {
            Text("실질 보증금 이자")
          } else {
            Text("보증금 이자")
          }
          Text("(년 / 월)")
            .font(.caption)
          Spacer()
          Text("\(deposit_interest, specifier: "%0.0f") 만원")
          Text("/")
          Text("\(deposit_interest / 12, specifier: "%0.1f") 만원")
        }
        if is_loan {
          HStack {
            Text("대출 전세금 이자")
            Text("(년 / 월)")
              .font(.caption)
            Spacer()
            Text("\(loan_interest, specifier: "%0.0f") 만원")
            Text("/")
            Text("\(loan_interest / 12, specifier: "%0.1f") 만원")
          }
        }
      }
      
      Section(header: Text("소비 금액")) {
        HStack {
          Text("월")
          Spacer()
          Text("\(consumption_amount, specifier: "%0.f") 만원")
        }
      }
    }
    .navigationBarTitle("소비 정보")
  }
}

struct ResultView_Previews: PreviewProvider {
  static var previews: some View {
    ResultView()
  }
}
