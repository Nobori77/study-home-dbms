-- 1. 기본 복습 문제
-- 문제 1

-- TBL_MEMBER 테이블을 보고 각 컬럼의 의미와 제약조건을 설명해보세요.

-- ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY
-- 회원 번호 기본키(PK)라서 중복 불가, NULL 불가

-- MEMBER_EMAIL VARCHAR2(255) UNIQUE NOT NULL
-- 회원 이메일
-- UNIQUE: 중복 불가
-- NOT NULL: 반드시 입력

-- MEMBER_PASSWORD VARCHAR2(255)
-- 회원 비밀번호 제약조건 없음

-- MEMBER_NAME VARCHAR(255) NOT NULL
-- 회원 이름 반드시 입력해야 함

--문제 2

-- TBL_PRODUCT에서 PRODUCT_PRICE와 PRODUCT_STOCK에 DEFAULT를 준 이유를 설명해보세요.
-- PRODUCT_PRICE, PRODUCT_STOCK에 DEFAULT를 준 이유
-- 값을 따로 입력하지 않아도 기본값이 자동으로 들어가게 하기 위해서
-- PRODUCT_PRICE NUMBER DEFAULT 0
-- 가격 미입력 시 0원으로 처리
-- PRODUCT_STOCK NUMBER DEFAULT 999
-- 재고를 따로 입력하지 않으면 기본 재고 999로 처리
-- 즉, INSERT 시 누락된 값을 자동 보완하려는 목적


-- 문제 3
--
-- TBL_ORDER가 어떤 관계를 표현하는 테이블인지 설명해보세요.
-- 특히 MEMBER_ID, PRODUCT_ID가 왜 필요한지도 같이 말해보세요.

-- BL_ORDER는 회원과 상품의 주문 관계를 표현하는 테이블
-- 한 회원은 여러 상품을 주문할 수 있음
-- 한 상품은 여러 회원에게 주문될 수 있음

-- MEMBER_ID, PRODUCT_ID가 필요한 이유:
-- 어떤 회원이 주문했는지 알기 위해 MEMBER_ID 필요
-- 어떤 상품을 주문했는지 알기 위해 PRODUCT_ID 필요
-- 즉, 주문이라는 행위의 주체와 대상을 연결하는 역할

-- 문제 4

-- TBL_POST와 TBL_MEMBER의 관계는 무엇인가요?
-- 1:N, N:M 중 어떤 관계인지 쓰고 이유도 설명해보세요.

-- TBL_POST와 TBL_MEMBER의 관계는 1:N
-- 이유:
-- 한 명의 회원은 여러 개의 게시글을 작성할 수 있음
-- 하나의 게시글은 한 명의 회원이 작성함
-- 그래서 회원 1명 : 게시글 여러 개 = 1:N

-- 2. 관계형 모델 문제
-- 문제 5
-- 유치원 체험학습 구조에서 아래 테이블들의 관계를 전부 적어보세요.
-- TBL_CHILD
-- TBL_PARENT
-- TBL_FIELD_TRIP
-- TBL_FIELD_TRIP_IMAGE
-- TBL_APPLY

-- 예시 형식:
-- 부모 : 아이 = 1:N

-- TBL_CHILD : TBL_PARENT = 1:N 또는 1:1처럼 보이지만 현재 구조상 자녀 1명에 부모 여러 명 가능
-- TBL_FIELD_TRIP : TBL_FIELD_TRIP_IMAGE = 1:N
-- TBL_CHILD : TBL_APPLY = 1:N
-- TBL_FIELD_TRIP : TBL_APPLY = 1:N
-- TBL_CHILD : TBL_FIELD_TRIP = N:M 이 관계를 TBL_APPLY가 풀어주고 있음



-- 문제 6
-- TBL_FIELD_TRIP_IMAGE를 따로 분리한 이유를 설명해보세요.


-- 체험학습 하나에 이미지가 여러 장 들어갈 수 있기 때문
-- 만약 TBL_FIELD_TRIP 안에 이미지 컬럼을 여러 개 만들면:
-- IMAGE1, IMAGE2, IMAGE3 식으로 비효율적
-- 이미지 개수가 늘어나면 구조 변경 필요
-- 정규화에도 좋지 않음
-- 그래서 이미지 테이블을 분리해서
-- 체험학습 1개 : 이미지 여러 개 구조로 만든 것

-- 문제 7
--
-- 아이들이 여러 번 체험학습에 등록할 수 있다는 요구사항을 어떤 테이블이 해결하고 있나요?
-- 그리고 왜 그렇게 설계했는지 설명해보세요.

-- 아이들이 여러 번 체험학습에 등록할 수 있다는 요구사항은 TBL_APPLY가 해결
-- 이유:
-- 한 아이는 여러 체험학습에 신청 가능
-- 한 체험학습에는 여러 아이가 신청 가능
-- 즉, CHILD와 FIELD_TRIP은 N:M 관계이고
-- 이걸 직접 표현하지 않고 중간 테이블 TBL_APPLY 로 풀어냄


-- 문제 8
-- 현재 TBL_PARENT에 CHILD_ID가 들어가 있는데, 이 구조가 의미하는 관계는 무엇인가요?
-- 이 설계가 실제 현실과 완전히 맞는지 생각해보고 의견을 적어보세요.

-- 현재 TBL_PARENT에 CHILD_ID가 들어 있다는 것은
-- 부모 테이블이 자녀를 참조하고 있으므로
-- 부모 한 명이 특정 자녀 한 명에 연결되는 구조입니다
-- 이 구조가 의미하는 것:
-- 여러 부모가 한 자녀를 가질 수 있음
-- 하지만 부모 한 명이 여러 자녀를 가지기는 어려움


-- 3. 정규화 / 설계 판단 문제
-- 문제 9
-- 광고 회사 예제에서 기업과 광고의 관계를 설명해보세요.
-- 한 기업은 여러 광고를 신청할 수 있다
-- 한 광고는 여러 기업이 신청할 수 있다
-- 이 요구사항이라면 현재 TBL_AD_APPLY 같은 테이블이 왜 필요한가요?

-- 기업과 광고의 관계는 N:M으로 볼 수 있습니다.
-- 한 기업은 여러 광고를 신청할 수 있음
-- 한 광고도 여러 기업이 신청할 수 있음
-- 그래서 TBL_AD_APPLY 같은 중간 테이블이 필요

-- 문제 10
-- 카테고리를 아래처럼 나눈 이유를 설명해보세요.
-- 대카테고리
-- 중카테고리
-- 소카테고리
-- 그냥 하나의 카테고리 테이블로 만들지 않고 나눈 장점도 같이 적어보세요.

-- 카테고리를 대/중/소로 나눈 이유는 계층 구조를 표현하기 위해서입니다.
-- 예:
-- 대카테고리: 식품
-- 중카테고리: 음료
-- 소카테고리: 탄산음료
-- 장점:
-- 분류 체계가 명확함
-- 상위/하위 카테고리 관리 쉬움
-- 검색, 통계, 분류에 유리함
-- 하나의 카테고리 테이블로만 만들면 계층 표현이 복잡해질 수 있음

-- 문제 11
-- TBL_COMPANY의 COMPNAY_TYPE에 CHECK 제약조건을 건 이유를 설명해보세요.

-- COMPNAY_TYPE에 CHECK 제약조건을 건 이유는
-- 허용된 값만 저장하도록 제한하기 위해서
-- 즉 아래 값만 들어갈 수 있습니다.
-- 스타트업
-- 중소기업
-- 중견기업
-- 대기업
-- 이렇게 하면 오타나 이상한 값 입력을 막을 수 있음


-- 문제 12
-- 아래 중 어떤 컬럼에 UNIQUE를 주는 것이 적절한지 골라보세요.
-- CHILD_NAME
-- PARENT_PHONE
-- COMPANY_NAME
-- AD_TITLE
-- 그리고 이유도 써보세요.
 
-- COMPANY_NAME : 회사명은 보통 중복 없이 관리하려는 경우가 많음
-- PARENT_PHONE : 상황에 따라 가능할것 같음


-- 4. 직접 DDL 작성 문제
-- 문제 13
-- 다음 요구사항에 맞는 테이블을 설계해보세요.
-- 요구사항
-- 선생님 정보: 이름, 나이, 전화번호
-- 반 정보: 반 이름, 정원
-- 한 명의 선생님은 여러 반을 맡을 수 있음
-- 한 반에는 한 명의 선생님만 배정됨
-- 작성할 것:
-- 시퀀스
-- 테이블
-- PK
-- FK

CREATE SEQUENCE SEQ_TEACHER;
CREATE TABLE TBL_TEACHER(
    ID NUMBER CONSTRAINT PK_TEACHER PRIMARY KEY,
    TEACHER_NAME VARCHAR2(255) NOT NULL,
    TEACHER_AGE NUMBER,
    TEACHER_PHONE VARCHAR2(255)
);

CREATE SEQUENCE SEQ_CLASS;
CREATE TABLE TBL_CLASS(
    ID NUMBER CONSTRAINT PK_CLASS PRIMARY KEY,
    CLASS_NAME VARCHAR2(255) NOT NULL,
    CLASS_CAPACITY NUMBER,
    TEACHER_ID NUMBER,
    CONSTRAINT FK_CLASS_TEACHER FOREIGN KEY(TEACHER_ID)
    REFERENCES TBL_TEACHER(ID)
);

-- 관계 선생님 1 : 반 N

-- 문제 14
-- 다음 요구사항에 맞는 테이블을 설계해보세요.
-- 요구사항
-- 도서 정보: 제목, 저자, 가격
-- 회원 정보: 이름, 전화번호
-- 회원은 여러 권의 책을 대여할 수 있음
-- 한 권의 책은 여러 회원이 시간차를 두고 대여될 수 있음
-- 대여일, 반납일이 필요함

CREATE SEQUENCE SEQ_BOOK;
CREATE TABLE TBL_BOOK(
    ID NUMBER CONSTRAINT PK_BOOK PRIMARY KEY,
    BOOK_TITLE VARCHAR2(255) NOT NULL,
    BOOK_AUTHOR VARCHAR2(255) NOT NULL,
    BOOK_PRICE NUMBER DEFAULT 0
);

CREATE SEQUENCE SEQ_USER;
CREATE TABLE TBL_USER(
    ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
    USER_NAME VARCHAR2(255) NOT NULL,
    USER_PHONE VARCHAR2(255)
);

CREATE SEQUENCE SEQ_RENTAL;
CREATE TABLE TBL_RENTAL(
    ID NUMBER CONSTRAINT PK_RENTAL PRIMARY KEY,
    USER_ID NUMBER,
    BOOK_ID NUMBER,
    RENTAL_DATE DATE,
    RETURN_DATE DATE,
    CONSTRAINT FK_RENTAL_USER FOREIGN KEY(USER_ID)
    REFERENCES TBL_USER(ID),
    CONSTRAINT FK_RENTAL_BOOK FOREIGN KEY(BOOK_ID)
    REFERENCES TBL_BOOK(ID)
);


-- 문제 15
-- 다음 요구사항에 맞게 이미지 테이블을 분리해서 설계해보세요.
-- 요구사항
-- 게시글: 제목, 내용
-- 게시글 하나에 이미지 여러 장 첨부 가능

CREATE SEQUENCE SEQ_BOARD;
CREATE TABLE TBL_BOARD(
    ID NUMBER CONSTRAINT PK_BOARD PRIMARY KEY,
    BOARD_TITLE VARCHAR2(255) NOT NULL,
    BOARD_CONTENT VARCHAR2(255) NOT NULL
);

CREATE SEQUENCE SEQ_BOARD_IMAGE;
CREATE TABLE TBL_BOARD_IMAGE(
    ID NUMBER CONSTRAINT PK_BOARD_IMAGE PRIMARY KEY,
    IMAGE_PATH VARCHAR2(255),
    IMAGE_NAME VARCHAR2(255),
    BOARD_ID NUMBER,
    CONSTRAINT FK_BOARD_IMAGE_BOARD FOREIGN KEY(BOARD_ID)
    REFERENCES TBL_BOARD(ID)
);

-- 게시글 1 : 이미지 N