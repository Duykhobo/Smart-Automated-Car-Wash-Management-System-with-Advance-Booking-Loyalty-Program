package dto;

public class MemberTier {
    private int tierId;
    private String tierName;
    private int minWashes;
    private double minSpend;
    private double pointsModifier;
    private int priorityRank;

    private int maxBookingDays;
    private String badgeClass;
    private String bannerBorder;
    private String bannerBg;
    private String bannerIcon;
    private String bannerText;

    public MemberTier() {}

    public MemberTier(int tierId, String tierName, int minWashes, double minSpend, double pointsModifier, int priorityRank,
                      int maxBookingDays, String badgeClass, String bannerBorder, String bannerBg, String bannerIcon, String bannerText) {
        this.tierId = tierId;
        this.tierName = tierName;
        this.minWashes = minWashes;
        this.minSpend = minSpend;
        this.pointsModifier = pointsModifier;
        this.priorityRank = priorityRank;
        this.maxBookingDays = maxBookingDays;
        this.badgeClass = badgeClass;
        this.bannerBorder = bannerBorder;
        this.bannerBg = bannerBg;
        this.bannerIcon = bannerIcon;
        this.bannerText = bannerText;
    }

    public int getTierId() { return tierId; }
    public void setTierId(int tierId) { this.tierId = tierId; }
    public String getTierName() { return tierName; }
    public void setTierName(String tierName) { this.tierName = tierName; }
    public int getMinWashes() { return minWashes; }
    public void setMinWashes(int minWashes) { this.minWashes = minWashes; }
    public double getMinSpend() { return minSpend; }
    public void setMinSpend(double minSpend) { this.minSpend = minSpend; }
    public double getPointsModifier() { return pointsModifier; }
    public void setPointsModifier(double pointsModifier) { this.pointsModifier = pointsModifier; }
    public int getPriorityRank() { return priorityRank; }
    public void setPriorityRank(int priorityRank) { this.priorityRank = priorityRank; }
    public int getMaxBookingDays() { return maxBookingDays; }
    public void setMaxBookingDays(int maxBookingDays) { this.maxBookingDays = maxBookingDays; }
    public String getBadgeClass() { return badgeClass; }
    public void setBadgeClass(String badgeClass) { this.badgeClass = badgeClass; }
    public String getBannerBorder() { return bannerBorder; }
    public void setBannerBorder(String bannerBorder) { this.bannerBorder = bannerBorder; }
    public String getBannerBg() { return bannerBg; }
    public void setBannerBg(String bannerBg) { this.bannerBg = bannerBg; }
    public String getBannerIcon() { return bannerIcon; }
    public void setBannerIcon(String bannerIcon) { this.bannerIcon = bannerIcon; }
    public String getBannerText() { return bannerText; }
    public void setBannerText(String bannerText) { this.bannerText = bannerText; }
}
