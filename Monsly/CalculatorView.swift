//
//  CalculatorView.swift
//  Monsly
//
//  Created by 정현민 on 2020/09/02.
//  Copyright © 2020 Hyunmin. All rights reserved.
//

import SwiftUI

struct CalculatorView: View {
  @State private var deposit_amount: Double = 0
  @State private var rent_amout: Double = 0
  @State private var management_amount: Double = 0
  
  @State private var is_loan: Bool = false
  @State private var loan_interest_rate: Double = 0
  @State private var loan_amount: Double = 0
  
  var body: some View {
    Form {
      Section(header: Text("기본 정보")) {
        VStack(alignment: .leading) {
          HStack {
            Text("보증금")
            Spacer()
            if deposit_amount >= 10000 {
              Text("\(floor(deposit_amount / 10000), specifier: "%0.f") 억")
            }
            Text("\(deposit_amount.truncatingRemainder(dividingBy: 10000), specifier: "%0.f") 만원")
              .font(.body)
          }
          HStack {
            Button(action: {
              self.deposit_amount -= 100
            }, label: {
              Image(systemName: "minus.square")
                .foregroundColor(.gray)
            })
            Slider(value: $deposit_amount, in: 0...20000, step: 100)
            Button(action: {
              self.deposit_amount += 100
            }, label: {
              Image(systemName: "plus.square")
                .foregroundColor(.gray)
            })
          }
        }
        VStack(alignment: .leading) {
          HStack {
            Text("월세")
            Spacer()
            Text("\(rent_amout, specifier: "%.f") 만원")
          }
          HStack {
            Button(action: {
              self.rent_amout -= 100
            }, label: {
              Image(systemName: "minus.square")
                .foregroundColor(.gray)
            })
            Slider(value: $rent_amout, in: 0...200, step: 1)
            Button(action: {
              self.rent_amout += 100
            }, label: {
              Image(systemName: "plus.square")
                .foregroundColor(.gray)
            })
          }
        }
        VStack(alignment: .leading) {
          HStack {
            Text("관리비")
            Spacer()
            Text("\(management_amount, specifier: "%.f") 만원")
          }
          HStack {
            Button(action: {
              self.management_amount -= 100
            }, label: {
              Image(systemName: "minus.square")
                .foregroundColor(.gray)
            })
            Slider(value: $management_amount, in: 0...20, step: 1)
            Button(action: {
              self.management_amount += 100
            }, label: {
              Image(systemName: "plus.square")
                .foregroundColor(.gray)
            })
          }
        }
      }
      Section(header: Text("대출")) {
        Toggle(isOn: $is_loan) {
          Text("전세금 대출")
        }
        .onTapGesture {
          if self.is_loan {
            self.loan_amount = 0
            self.loan_interest_rate = 0
          } else {
            if self.deposit_amount == 0 {
              self.loan_amount = 1
            }
          }
        }
        if is_loan {
          VStack(alignment: .leading) {
            HStack {
              Text("대출금")
              Spacer()
              Text("\(loan_amount, specifier: "%.f") 만원")
            }
            HStack {
              Button(action: {
                self.loan_amount -= 100
              }, label: {
                Image(systemName: "minus.square")
                  .foregroundColor(.gray)
              })
              Slider(value: $loan_amount, in: 0...deposit_amount + 100, step: 100)
              Button(action: {
                self.loan_amount += 100
              }, label: {
                Image(systemName: "plus.square")
                  .foregroundColor(.gray)
              })
            }
          }
          VStack(alignment: .leading) {
            HStack {
              Text("대출 이자")
              Spacer()
              Text("\(loan_interest_rate * 100, specifier: "%.2f") %")
            }
            HStack {
              Button(action: {
                self.loan_interest_rate -= 0.0001
              }, label: {
                Image(systemName: "minus.square")
                  .foregroundColor(.gray)
              })
              Slider(value: $loan_interest_rate, in: 0...0.05, step: 0.0001)
              Button(action: {
                self.loan_interest_rate += 0.0001
              }, label: {
                Image(systemName: "plus.square")
                  .foregroundColor(.gray)
              })
            }
          }
        }
      }
    }
    .navigationBarTitle("집 정보")
    .navigationBarItems(trailing:
      NavigationLink(destination: ResultView(deposit_amount: deposit_amount, loan_amount: loan_amount, rent_amount: rent_amout, management_amount: management_amount, is_loan: is_loan, loan_interest_rate: loan_interest_rate)) {
        Text("계산하기")
    })
  }
}

struct CalculatorView_Previews: PreviewProvider {
  static var previews: some View {
    CalculatorView()
  }
}
