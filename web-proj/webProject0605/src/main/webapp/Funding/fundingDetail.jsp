<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
    import="model.FundingBoard, model.ProjectContent, model.ProjectProduct, model.User"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page
    import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<%@ page import="java.util.Base64"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Funding Detail</title>
<link rel="stylesheet" href="fundingDetail.css">
</head>
<body>
    <%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Log/loginForm.jsp");
        return;
    }

    String boardIdStr = request.getParameter("id");
    if (boardIdStr == null) {
        response.sendRedirect("fundingList.jsp");
        return;
    }

    int boardId = Integer.parseInt(boardIdStr);

    String dbURL = "jdbc:mysql://localhost:3306/User";
    String dbUser = "root";
    String dbPass = "wjdtjgus04";

    FundingBoard board = null;
    List<ProjectContent> contents = new ArrayList<>();
    List<ProjectProduct> products = new ArrayList<>();

    System.out.println("Connecting to database...");
    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
        System.out.println("Database connection successful");

        String boardSql = "SELECT * FROM board WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(boardSql)) {
            stmt.setInt(1, boardId);
            try (ResultSet rs = stmt.executeQuery()) {
        if (rs.next()) {
            board = new FundingBoard(rs.getString("userId"), rs.getString("category"), rs.getString("productName"),
                    rs.getString("startDate"), rs.getString("endDate"), rs.getString("paymentEndDate"),
                    rs.getDouble("targetAmount"), rs.getString("selfIntroduction"));
            board.setId(rs.getInt("id"));
            board.setAmountRaised(rs.getDouble("amountRaised"));
            board.setRemainingDays(rs.getInt("remainingDays"));
            board.setSponsorCount(rs.getInt("sponsorCount"));
            board.setAchievementRate(rs.getDouble("achievementRate"));
            board.setCreationTime(rs.getString("creationTime"));
        } else {
            System.out.println("No board found with ID: " + boardId);
        }
            }
        }

        if (board == null) {
            System.out.println("Board is null");
            response.sendRedirect("fundingList.jsp");
            return;
        }

        String contentSql = "SELECT * FROM project_contents WHERE projectId = ?";
        try (PreparedStatement contentStmt = conn.prepareStatement(contentSql)) {
            contentStmt.setInt(1, boardId);
            try (ResultSet rs = contentStmt.executeQuery()) {
        while (rs.next()) {
            ProjectContent content = new ProjectContent();
            content.setId(rs.getInt("id"));
            content.setProjectId(rs.getInt("projectId"));
            content.setTitle(rs.getString("title"));
            content.setSubtitle(rs.getString("subtitle"));
            content.setContent(rs.getString("content"));
            contents.add(content);
        }
            }
        }

        String productSql = "SELECT * FROM project_products WHERE projectId = ?";
        try (PreparedStatement productStmt = conn.prepareStatement(productSql)) {
            productStmt.setInt(1, boardId);
            try (ResultSet rs = productStmt.executeQuery()) {
        while (rs.next()) {
            ProjectProduct product = new ProjectProduct();
            product.setId(rs.getInt("id"));
            product.setProjectId(rs.getInt("projectId"));
            product.setProductName(rs.getString("productName"));
            product.setProductPrice(rs.getInt("productPrice"));
            product.setProductImage(rs.getBytes("productImage"));
            products.add(product);
        }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    %>
    <div class="header">
        <h6><%=board != null ? board.getCategory() : ""%></h6>
        <h6><%=board != null ? board.getId() : ""%></h6>
        <h1><%=board != null ? board.getProductName() : ""%></h1>
    </div>
    <div class="container">
        <!-- Main Content Area -->
        <div class="main-content">
            <div class="main-image" style="background-color: #e0e0e0;">
                <%
                if (board != null && board.getImage() != null) {
                %>

                <%
                } else {
                %>
                <div style="width: 100%; height: 400px; background-color: #e0e0e0;"></div>
                <%
                }
                %>
            </div>
            <div class="project-stats">
                <p>
                    모인금액:
                    <%=board != null ? board.getAmountRaised() : ""%>원
                    <%=board != null ? board.getAchievementRate() : ""%>%
                </p>
                <p>
                    남은시간:
                    <%=board != null ? board.getRemainingDays() : ""%>일
                </p>
                <p>
                    후원자:
                    <%=board != null ? board.getSponsorCount() : ""%>명
                </p>
                <p>
                    목표금액:
                    <%=board != null ? board.getTargetAmount() : ""%>원
                </p>
                <p>
                    펀딩 기간:
                    <%=board != null ? board.getStartDate() : ""%>
                    ~
                    <%=board != null ? board.getEndDate() : ""%></p>
                <p>
                    결제: 목표금액 달성 시
                    <%=board != null ? board.getPaymentEndDate() : ""%>에 결제 진행
                </p>
            </div>
            <form action="${pageContext.request.contextPath}/Funding/DonateForm.jsp" method="post">
                <input type="hidden" name="boardId" value="<%= board.getId() %>">
                <input type="hidden" id="hidden-total-amount" name="totalAmount" value="0">
                <button class="donate-button" type="submit">이 프로젝트 후원하기</button>
            </form>
        </div>
        <!-- Sidebar Area -->
        <div class="sidebar">
            <div class="creator-info">
                <h2>창작자 소개</h2>
                <div class="creator-image" style="background-color: #e0e0e0;"></div>
                <p><%=board != null ? board.getSelfIntroduction() : ""%></p>
                <button class="follow-button">팔로우</button>
                <button class="contact-button">사업자 문의</button>
            </div>
            <div class="rewards">
                <!-- 제품구성 -->
                <h2>선물 선택</h2>
                <div id="selected-rewards"></div>
                <div id="total-amount" style="font-weight: bold; margin-top: 10px;">
                    총 합계: <span id="grand-total">0</span>원
                </div>
                <%
                if (products != null && !products.isEmpty()) {
                    for (ProjectProduct product : products) {
                %>
                <div class="reward-item"
                    onclick="selectReward('<%=product.getId()%>', '<%=product.getProductName()%>', <%=product.getProductPrice()%>)">
                    <p style="margin: 0; padding: 0;"><%=product.getProductName()%></p>
                    <p>
                        <strong><%=product.getProductPrice()%>원</strong>
                    </p>
                </div>
                <%
                }
                } else {
                %>
                <p>제품 정보가 없습니다.</p>
                <%
                }
                %>
            </div>
        </div>
    </div>
    <div class="details">
        <div class="tab-menu">
            <button class="tab-link active"
                onclick="openTab(event, 'project-plan')">프로젝트 계획</button>
            <button class="tab-link" onclick="openTab(event, 'update')">업데이트</button>
            <button class="tab-link" onclick="openTab(event, 'community')">커뮤니티</button>
            <button class="tab-link" onclick="openTab(event, 'review')">후기</button>
        </div>
        <div id="project-plan" class="tab-content">
            <h2>소개</h2>
            <div class="intro-image" style="background-color: #e0e0e0;"></div>
            <p>
                <%
                if (contents != null && !contents.isEmpty()) {
                    for (ProjectContent content : contents) {
                %>
            
            <div class="content-item">
                <h4><%=content.getTitle()%></h4>
                <h5><%=content.getSubtitle()%></h5>
                <p><%=content.getContent()%></p>
            </div>
            <%
            }
            } else {
            %>
            <p>콘텐츠가 없습니다.</p>
            <%
            }
            %>
            
        </div>
    </div>
    <script>
    let selectedRewards = [];

    function selectReward(id, name, price) {
        if (!selectedRewards.some(reward => reward.id === id)) {
            selectedRewards.push({ id, name, price, quantity: 1 });
            renderSelectedRewards();
        }
    }

    function updateQuantity(id, amount) {
        let reward = selectedRewards.find(reward => reward.id === id);
        if (reward) {
            reward.quantity = Math.max(1, reward.quantity + amount); // 최소 수량을 1로 설정
            renderSelectedRewards();
        }
    }

    function removeReward(id) {
        selectedRewards = selectedRewards.filter(reward => reward.id !== id);
        renderSelectedRewards();
    }

    function renderSelectedRewards() {
        const selectedRewardsContainer = document.getElementById("selected-rewards");
        selectedRewardsContainer.innerHTML = "";
        let grandTotal = 0;

        selectedRewards.forEach(reward => {
            grandTotal += reward.price * reward.quantity;
            selectedRewardsContainer.innerHTML += `
                <div class="reward-item">
                    <p>${reward.name}</p>
                    <p>${reward.price.toLocaleString()}원</p>
                    <div class="quantity-control">
                        <button onclick="updateQuantity('${reward.id}', -1)">-</button>
                        <input type="text" value="${reward.quantity}" readonly>
                        <button onclick="updateQuantity('${reward.id}', 1)">+</button>
                    </div>
                    <button class="remove-reward-button" onclick="removeReward('${reward.id}')">제거</button>
                </div>
            `;
        });

        document.getElementById("grand-total").innerText = grandTotal.toLocaleString();
        document.getElementById("hidden-total-amount").value = grandTotal;
    }

    function openTab(evt, tabName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tab-content");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tab-link");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += " active";
    }
    document.getElementById("project-plan").style.display = "block";
    </script>
</body>
</html>




